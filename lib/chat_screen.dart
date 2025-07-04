import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];

  // Replace with your free API key 
  final String apiKey = "sk-777f7f3ee71c4214b890c64f126bba1f";
  final String apiUrl = "https://api.deepseek.com/v1/chat/completions"; // Example API

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({"sender": "user", "text": userMessage});
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",  // 
          "messages": [
            {"role": "system", "content": "You are a helpful assistant for disaster help and precautions."},
            {"role": "user", "content": userMessage}
          ]
        }),
      );
  debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String botMessage = responseData['choices'][0]['message']['content'];

        setState(() {
          messages.add({"sender": "bot", "text": botMessage});
        });
      } else {
        setState(() {
          messages.add({"sender": "bot", "text": "Error: Unable to get response from AI."});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"sender": "bot", "text": "Error: Network issue or API error."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Chatbot"),
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: messages[index]["sender"] == "user" ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: messages[index]["sender"] == "user" ? Colors.blue[200] : Colors.green[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(messages[index]["text"]!),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask about disaster help...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
