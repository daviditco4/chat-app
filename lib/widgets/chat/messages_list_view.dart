import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helpers/message_keys.dart';
import '../../pages/chat_page.dart' show MESSAGES_COLLECTION_PATH;
import 'message_bubble.dart';

class MessagesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final msgCollec = firestore.collection(MESSAGES_COLLECTION_PATH);

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: msgCollec.orderBy(MessageKeys.crAt, descending: true).snapshots(),
      builder: (_, messagesSnapshot) {
        final List<DocumentSnapshot<Map<String, dynamic>>>? documents;
        String? lastUid;

        return messagesSnapshot.connectionState == ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                reverse: true,
                itemCount: (documents = messagesSnapshot.data!.docs).length,
                itemBuilder: (_, index) {
                  final document = documents![index];
                  final docData = document.data()!;
                  final cr = docData[MessageKeys.cr] as Map<String, dynamic>;
                  final uid = cr[MessageKeys.uid];
                  final photoURL = cr[MessageKeys.pto];
                  final creatorPhotoURL = (uid != lastUid) ? photoURL : null;
                  lastUid = uid;

                  return MessageBubble(
                    key: ValueKey(document.id),
                    text: docData[MessageKeys.txt],
                    byMe: uid == FirebaseAuth.instance.currentUser!.uid,
                    creatorUsername: cr[MessageKeys.usn],
                    creatorPhotoURL: creatorPhotoURL,
                  );
                },
              );
      },
    );
  }
}
