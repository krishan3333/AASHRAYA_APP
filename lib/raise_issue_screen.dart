import 'package:flutter/material.dart';

class RaiseIssueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Raise an Issue"), backgroundColor: Colors.green),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Describe your issue",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Issue submitted! Admins will respond within 24 hours.")),
                );
                Navigator.pop(context); // Go back to home
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
