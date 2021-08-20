import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart' show CHAT_TOPIC;
import '../widgets/chat/messages_list_view.dart';
import '../widgets/chat/send_message_field.dart';

const MESSAGES_COLLECTION_PATH = '${CHAT_TOPIC}Messages';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) {
              final colorSch = Theme.of(ctx).colorScheme;

              return [
                PopupMenuItem(
                  value: 'signout',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout, color: colorSch.error),
                      const SizedBox(width: 24.0),
                      Text('Sign Out', style: TextStyle(color: colorSch.error)),
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'signout') FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: MessagesListView()),
          const SizedBox(height: 8.0),
          SendMessageField(),
        ],
      ),
    );
  }
}
