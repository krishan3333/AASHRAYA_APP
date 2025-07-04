import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Disaster News")),
      body: Center(child: Text("News about disasters will be shown here.")),
    );
  }
}
