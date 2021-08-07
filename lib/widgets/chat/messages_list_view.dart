// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessagesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final msgsCollection = Firestore.instance.collection('messages');

    return StreamBuilder<QuerySnapshot>(
      stream: msgsCollection.orderBy('createdAt', descending: true).snapshots(),
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
    );
  }
}
