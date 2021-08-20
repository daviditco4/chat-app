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
      builder: (_, snapshot) {
        final isWaiting = snapshot.connectionState == ConnectionState.waiting;
        if (isWaiting) return const Center(child: CircularProgressIndicator());

        final docs = snapshot.data!.docs;
        final n = docs.length;

        return ListView.builder(
          reverse: true,
          itemCount: n,
          itemBuilder: (_, i) {
            final document = docs[i];
            final documentData = document.data();
            const crKey = MessageKeys.cr;
            const uidKey = MessageKeys.uid;
            final creator = documentData[crKey];
            final uid = creator[uidKey];
            final usn = (i == n - 1 || uid != docs[i + 1].data()[crKey][uidKey])
                ? creator[MessageKeys.usn]
                : null;
            final crPhoto = (i == 0 || uid != docs[i - 1].data()[crKey][uidKey])
                ? creator[MessageKeys.pto]
                : null;

            return MessageBubble(
              key: ValueKey(document.id),
              text: documentData[MessageKeys.txt],
              byMe: uid == FirebaseAuth.instance.currentUser!.uid,
              creatorUsername: usn,
              creatorPhotoURL: crPhoto,
            );
          },
        );
      },
    );
  }
}
