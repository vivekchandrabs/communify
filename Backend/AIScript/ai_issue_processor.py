import os
import json
from typing import Dict, Any, List
from geopy.distance import geodesic
from PIL import Image
import openai
import torch
from transformers import CLIPProcessor, CLIPModel

# --- Configuration ---
openai.api_key = os.getenv("OPENAI_API_KEY")

clip_model = CLIPModel.from_pretrained("openai/clip-vit-base-patch32")
clip_processor = CLIPProcessor.from_pretrained("openai/clip-vit-base-patch32")

# --- Constants ---
TEXT_SIMILARITY_THRESHOLD = 0.8
MAX_RADIUS_METERS = 20

# --- Step 1: Analyze Image Content ---
def analyze_image(image_path: str) -> str:
    image = Image.open(image_path).convert("RGB")
    labels = [
        "pothole", "fallen tree", "garbage", "damaged sign", "road crack",
        "water leak", "overflowing drain", "illegal parking", "construction debris", "flood"
    ]
    inputs = clip_processor(text=labels, images=image, return_tensors="pt", padding=True)
    outputs = clip_model(**inputs)
    probs = outputs.logits_per_image.softmax(dim=1)
    return labels[probs.argmax()]

# --- Step 2: Generate Human-Readable Summary ---
def summarize_issue(image_label: str, issue: Dict[str, Any]) -> str:
    prompt = (
        f"You are an experienced civil engineer working with a municipal public works department. "
        f"Based on the provided image classification '{image_label}' and the location "
        f"(latitude: {issue['latitude']}, longitude: {issue['longitude']}), write a concise, human-readable "
        f"summary of the infrastructure or civic issue identified in the image. "
        f"Include only relevant details that would help in documenting the issue for inspection or resolution."
    )
    response = openai.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a municipal civil engineer summarizing infrastructure issues."},
            {"role": "user", "content": prompt}
        ]
    )
    return response.choices[0].message.content.strip()

# --- Step 3: Assess Severity Level ---
def assess_severity(description: str) -> str:
    prompt = (
        f"You are a civil infrastructure expert evaluating urban hazards. "
        f"Classify the severity of this civic issue: '{description}' based on how urgently the municipality "
        f"should address it. Use the following severity levels:\n\n"
        f"- Low: Minor or cosmetic issues with no immediate risk.\n"
        f"- Moderate: Issues that should be fixed soon but pose minimal safety risks.\n"
        f"- High: Issues that may cause damage or safety concerns if not addressed soon.\n"
        f"- Critical: Immediate danger to public safety or major disruption.\n\n"
        f"Return only one of: Low, Moderate, High, or Critical."
    )
    response = openai.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "You are a public works specialist classifying issue severity."},
            {"role": "user", "content": prompt}
        ]
    )
    return response.choices[0].message.content.strip()

# --- Step 4: Text Similarity Check ---
def compute_similarity(desc1: str, desc2: str) -> float:
    prompt = (
        f"You are a language expert. Rate the semantic similarity (0 to 1) between these two civic issue descriptions:\n\n"
        f"Issue 1: {desc1}\n\nIssue 2: {desc2}\n\n"
        f"Return only a number between 0 and 1."
    )
    response = openai.chat.completions.create(
        model="gpt-4",
        messages=[
            {"role": "system", "content": "Respond with only a numeric value between 0 and 1."},
            {"role": "user", "content": prompt}
        ]
    )
    try:
        return float(response.choices[0].message.content.strip())
    except ValueError:
        return 0.0

# --- Main Function ---
def process_issue(issue: Dict[str, Any], compiled_issues: List[Dict[str, Any]] = None) -> Dict[str, Any]:
    compiled_issues = compiled_issues or []

    # Step 1: Image understanding
    image_label = analyze_image(issue["image_path"])
    summary = summarize_issue(image_label, issue)
    severity = assess_severity(summary)

    # Step 2: Check for nearby, similar compiled issues
    for entry in compiled_issues:
        distance_m = geodesic(
            (issue["latitude"], issue["longitude"]),
            (entry["latitude"], entry["longitude"])
        ).meters

        if distance_m <= MAX_RADIUS_METERS:
            similarity = compute_similarity(summary, entry["description"])
            if similarity >= TEXT_SIMILARITY_THRESHOLD:
                # Match found: update and return
                entry["report_count"] += 1
                entry["description"] = summary  # optionally: smarter merge logic
                entry["risk_level"] = severity
                return entry

    # Step 3: No match found, return new compiled issue
    return {
        "id": None,
        "latitude": issue["latitude"],
        "longitude": issue["longitude"],
        "title": image_label.capitalize(),
        "description": summary,
        "risk_level": severity,
        "report_count": 1
    }
