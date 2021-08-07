// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessagesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const centeredLoadingSpinner = Center(child: CircularProgressIndicator());
    final msgsCollec = Firestore.instance.collection('messages');

    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (_, userSnapshot) {
        if (userSnapshot.connectionState != ConnectionState.done) {
          return centeredLoadingSpinner;
        }
        return StreamBuilder<QuerySnapshot>(
          stream: msgsCollec.orderBy('createdAt', descending: true).snapshots(),
          builder: (_, msgsSnapshot) {
            final List<DocumentSnapshot>? docs;

            return msgsSnapshot.connectionState == ConnectionState.waiting
                ? centeredLoadingSpinner
                : ListView.builder(
                    reverse: true,
                    itemCount: (docs = msgsSnapshot.data!.documents).length,
                    itemBuilder: (_, index) {
                      final document = docs![index];

                      return MessageBubble(
                        key: ValueKey(document.documentID),
                        text: document['text'],
                        fromMe: document['fromUid'] == userSnapshot.data!.uid,
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
