// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessageField extends StatefulWidget {
  @override
  _SendMessageFieldState createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  final _textController = TextEditingController();
  var _sendEnabled = false;

  void _send() async {
    setState(() => _sendEnabled = false);
    final messageText = _textController.text.trim();
    final user = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection('messages').add(
      {'text': messageText, 'createdAt': Timestamp.now(), 'fromUid': user.uid},
    );

    _textController.clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const height = 56.0;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Theme(
              data: theme.copyWith(
                colorScheme: colorScheme.copyWith(primary: theme.hintColor),
              ),
              child: TextField(
                controller: _textController,
                onChanged: (value) {
                  setState(() => _sendEnabled = value.trim().isNotEmpty);
                },
                minLines: 1,
                maxLines: 6,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(height / 2)),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: height,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _sendEnabled ? colorScheme.secondary : theme.disabledColor,
            ),
            child: IconButton(
              icon: const Icon(Icons.send),
              splashRadius: height / 2,
              color: colorScheme.onSecondary,
              disabledColor: theme.hintColor,
              onPressed: _sendEnabled ? _send : null,
            ),
          ),
        ],
      ),
    );
  }
}
