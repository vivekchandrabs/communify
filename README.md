# Communify.io - SH401📍📱🤖

Empowering communities through AI-driven civic engagement.

In many neighborhoods, especially underserved ones, local issues often go unreported due to inefficient or inaccessible reporting systems. **Communify.io** provides a simple mobile-first solution that allows residents to report issues in real-time. Through AI-powered clustering, summarization, and prioritization, municipalities can act faster and smarter—making cities more inclusive and responsive.

---

## Project Description 🔍

The platform architecture is built around a smart issue reporting and resolution system with the following components:

- **Geo-Filtering** – Every issue report is tagged with a GPS location, allowing spatial clustering of nearby problems.
- **Text Similarity** – NLP techniques group similar issue descriptions to reduce duplication.
- **Image Analysis** – Visual similarity models help confirm duplicate issues even when text is vague or missing.
- **Summarization & Prioritization** – Clustered reports are summarized using LLMs and ranked by frequency and severity before being shown on the municipality dashboard.

---

## Technology Stack ⚙️

- **Frontend**

  - Mobile App – Flutter
  - Admin Dashboard – React.js / HTML + JS

- **Backend**

  - Framework – Laravel
  - AI Modules – OpenAI
  - Queue – RabbitMQ
  - Image Similarity – CLIP
  - Text Embeddings – OpenAI
  - Summarization – GPT-4o

- **Databases**

  - Raw Data – PostgreSQL

- **Deployment**
  - Containerization – Docker
  - Hosting – AWS / Render / Railway

---

## Environment Setup 🛠️

> Make sure Python (>=3.8) is installed along with Node.js (for frontend development).

Clone the repository and install backend dependencies:

```bash
git clone https://github.com/vivekchandra/communify.git
cd backend
pip install -r requirements.txt
"
```
