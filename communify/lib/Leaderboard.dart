import 'package:flutter/material.dart';

// Dummy LeaderboardPage for navigation
class LeaderboardPage extends StatelessWidget {
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
        child: Text(
          'Leaderboard Page',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
