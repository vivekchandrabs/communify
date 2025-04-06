import 'package:flutter/material.dart';
import 'issue.dart'; // Import the IssuePage

class SuccessPage extends StatelessWidget {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 100.0),
            SizedBox(height: 16.0), // Add spacing below the success symbol
            Text(
              'Thank you for being a responsible Citizen!',
              style: TextStyle(
                fontSize: 18.0, // Font size for the text
                fontWeight: FontWeight.bold, // Bold text
                color: Colors.black, // Black color for visibility
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0), // Add spacing below the text
            ElevatedButton(
              onPressed: () {
                // Navigate back to the IssuePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IssuePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Blue color for the button
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
              ),
              child: Text(
                'Submit Another Issue',
                style: TextStyle(
                  fontSize: 16.0,
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
