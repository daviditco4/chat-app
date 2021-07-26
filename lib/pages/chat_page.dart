import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        reverse: true,
        itemCount: 3,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text('Message ${index + 1}'),
          );
        },
      ),
    );
  }
}
