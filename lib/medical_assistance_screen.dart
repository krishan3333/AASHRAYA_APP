import 'package:flutter/material.dart';

class MedicalAssistanceScreen extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {"name": "Dr. Smith", "phone": "123-456-7890"},
    {"name": "Dr. Johnson", "phone": "987-654-3210"},
    {"name": "Dr. Williams", "phone": "555-555-5555"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nearby Doctors"), backgroundColor: Colors.green),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doctors[index]["name"]!),
            subtitle: Text("Phone: ${doctors[index]["phone"]}"),
            trailing: IconButton(
              icon: Icon(Icons.call, color: Colors.green),
              onPressed: () {
                // Call the doctor (on a real device)
                // launch("tel:${doctors[index]['phone']}");
              },
            ),
          );
        },
      ),
    );
  }
}
