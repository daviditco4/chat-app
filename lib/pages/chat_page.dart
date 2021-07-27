// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const messagesCollectionPath = 'chats/cLG4gutEgm0MutC2aDyu/messages';

    Firestore.instance.collection(messagesCollectionPath).snapshots().listen(
      (event) {
        event.documents.forEach((document) => print(document.data['text']));
      },
    );

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
