import 'package:flutter/material.dart';
import 'success.dart'; // Import the SuccessPage
import 'dart:io';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  File? _image; // Variable to store the captured image
  bool _isAssetImage = false; // Flag to check if the asset image is displayed
  bool _isSubmitted = false; // Flag to track if the image has been submitted
  bool _isSubmitting = false; // Flag to show loader on the submit button
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _uploadImage() async {
    // Add a 2-second delay before uploading the image
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _image = null; // Clear any previously captured image
      _isAssetImage = true; // Set the flag to display the asset image
      _isSubmitted = false; // Reset the submission state
    });
  }

  Future<void> _submitImage() async {
    setState(() {
      _isSubmitting = true; // Show loader on the submit button
    });

    // Add a 2-second delay before navigating to the success page
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isSubmitting = false; // Stop the loader
      _isSubmitted = true; // Mark the image as submitted
    });

    // Navigate to the success page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding around the logo
          child: Image.asset(
            'assets/logo.png', // Path to the logo in the assets folder
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Communify',
          style: TextStyle(
            color: Colors.white, // White color
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Upload Image', // Heading text
              style: TextStyle(
                fontSize: 20.0, // Larger font size for the heading
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.black, // Black color for visibility
              ),
              textAlign: TextAlign.center, // Center-align the heading
            ),
            SizedBox(height: 16.0), // Add spacing below the heading
            _isAssetImage
                ? Image.asset(
                  'assets/light.jpeg', // Display the asset image
                  height: 300.0,
                  fit: BoxFit.cover,
                )
                : _image == null
                ? Center(
                  child: Text(
                    'No image uploaded yet.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                )
                : Image.file(_image!, height: 300.0, fit: BoxFit.cover),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLength: 140, // Limit the description to 140 characters
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Update the UI when the description changes
              },
            ),
            SizedBox(height: 16.0),
            if (!_isAssetImage) // Show the button only if the image is not uploaded
              ElevatedButton(
                onPressed: _isSubmitted ? null : _uploadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSubmitted ? Colors.grey : Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  _isSubmitted ? 'Submitted' : 'Upload Image',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            SizedBox(height: 16.0),
            if (_isAssetImage && _descriptionController.text.isNotEmpty)
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child:
                    _isSubmitting
                        ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                        : Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
              ),
          ],
        ),
      ),
    );
  }
}
