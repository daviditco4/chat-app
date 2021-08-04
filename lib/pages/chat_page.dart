// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sch = Theme.of(context).colorScheme;
    const msgsCollectionPath = 'chats/cLG4gutEgm0MutC2aDyu/messages';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  value: 'signout',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout, color: sch.error),
                      const SizedBox(width: 24.0),
                      Text('Sign Out', style: TextStyle(color: sch.error)),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) => FirebaseAuth.instance.signOut(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(msgsCollectionPath).snapshots(),
        builder: (_, snapshot) {
          final List<DocumentSnapshot>? documents;

          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.all(12.0),
                  reverse: true,
                  itemCount: (documents = snapshot.data!.documents).length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(documents![index]['text']),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send),
        onPressed: () {
          Firestore.instance.collection(msgsCollectionPath).add(
            {'text': DateTime.now().toString()},
          );
        },
      ),
    );
  }
}
