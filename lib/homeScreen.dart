import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'chat_screen.dart'; // Import AI Chat Screen
import 'raise_issue_screen.dart'; // Import Raise Issue Screen
import 'medical_assistance_screen.dart'; // Import Medical Assistance Screen
import 'news_screen_api.dart'; // Add this at the top


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea( // 👈 Wrap with SafeArea
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.green[200],
          actions: [
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(25.269152, 82.993095), // IIT BHU
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(25.269152, 82.993095),
                      width: 40,
                      height: 40,
                      child: Icon(Icons.location_pin, color: Colors.blue, size: 40),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xffD2F9DF),
        indicatorColor: Color(0xff9DFFCE),
        // this is not optimized way of doing, will change it later
        
        selectedIndex: 0,
        destinations: [
          NavigationDestination(icon: IconButton(icon: Icon(Icons.place),onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },), label: "Explore"),
          NavigationDestination(icon: IconButton(icon: Icon(Icons.report_problem_rounded),onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RaiseIssueScreen()),
                );
              },), label: "Raise Issue"),
          NavigationDestination(icon: IconButton(icon: Icon(Icons.local_hospital_rounded),onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalAssistanceScreen()),
                );
              },), label: "Medical Consult"),
        ]
      ),
      ),
    );
  }

  Widget _bottomNavItem(IconData icon, String label, VoidCallback onTap) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: Icon(icon), onPressed: onTap),
        Text(label, style: TextStyle(fontSize: 10)),
      ],
    );
  }
}

// child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            // children: [
            //   _bottomNavItem(Icons.explore, "Explore", () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => NewsScreen()),
            //     );
            //   }),
            //   _bottomNavItem(Icons.warning, "Raise Issue", () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => RaiseIssueScreen()),
            //     );
            //   }),
            //   _bottomNavItem(Icons.local_hospital, "Medical Assistance", () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => MedicalAssistanceScreen()),
            //     );
            //   }),
            // ],
          // ),