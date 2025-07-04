import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final apiKey = "a2255de082a849a3f980481e1ea07fdc"; // Replace with your GNews API key
    final url = "https://gnews.io/api/v4/search?q=disaster&lang=en&token=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          articles = data["articles"];
          isLoading = false;
        });
      } else {
        print("Failed to load news: ${response.body}");
      }
    } catch (e) {
      print("Error fetching news: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Disaster News"), backgroundColor: Colors.green),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(article["title"]),
                    subtitle: Text(article["description"] ?? "No description"),
                    leading: article["image"] != null
                        ? Image.network(article["image"], width: 80, height: 80, fit: BoxFit.cover)
                        : Icon(Icons.image_not_supported),
                    onTap: () {
                      _openArticle(article["url"]);
                    },
                  ),
                );
              },
            ),
    );
  }

  void _openArticle(String url) {
    // Open the news article in a browser
    print("Open news: $url"); // Replace with actual web launcher if needed
  }
}
