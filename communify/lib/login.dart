import 'package:flutter/material.dart';
import 'issue.dart'; // Import the IssuePage

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Align content to the center
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png', // Path to the logo in the assets folder
                height: 150.0, // Make the logo large
              ),
            ),
            SizedBox(height: 16.0), // Add spacing below the logo
            Center(
              child: Text(
                'Communify', // Heading text
                style: TextStyle(
                  fontSize: 24.0, // Larger font size
                  fontWeight: FontWeight.bold, // Bold text
                  color: Colors.black, // Black color for visibility
                ),
              ),
            ),
            SizedBox(height: 32.0), // Add spacing below the heading
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the IssuePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IssuePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Black color
                elevation: 8.0, // Special effect: shadow elevation
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                ), // Padding for height
              ),
              child: Text(
                'Login',
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
