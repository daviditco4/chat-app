import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    const radV = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: radV, vertical: 6.0),
          constraints: BoxConstraints(
            minWidth: screenWidth * 0.15,
            maxWidth: screenWidth * 0.85,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColorDark,
            borderRadius: BorderRadius.circular(radV),
          ),
          padding: const EdgeInsets.symmetric(horizontal: radV, vertical: 10.0),
          // alignment: Alignment.centerRight,
          child: Text(
            text,
            style: TextStyle(color: theme.colorScheme.onPrimary),
            softWrap: true,
            textWidthBasis: TextWidthBasis.parent,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
