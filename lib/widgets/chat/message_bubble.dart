import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.text, required this.fromMe})
      : super(key: key);
  final String text;
  final bool fromMe;

  @override
  Widget build(BuildContext context) {
    const radVal = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final colorSch = theme.colorScheme;
    const bigRadius = Radius.circular(radVal);
    const smallRadius = Radius.circular(2.0);
    final borderRadius = BorderRadiusDirectional.only(
      topStart: bigRadius,
      topEnd: bigRadius,
      bottomStart: fromMe ? bigRadius : smallRadius,
      bottomEnd: !fromMe ? bigRadius : smallRadius,
    );

    return Align(
      alignment: fromMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        constraints: BoxConstraints(
          minWidth: screenWidth * 0.15,
          maxWidth: screenWidth * 0.85,
        ),
        decoration: BoxDecoration(
          color: fromMe
              ? theme.primaryColorDark
              : ElevationOverlay.applyOverlay(context, colorSch.surface, 4.0),
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: radVal, vertical: 10.0),
        child: Text(
          text,
          style: TextStyle(
            color: fromMe ? colorSch.onPrimary : colorSch.onSurface,
          ),
          softWrap: true,
          textWidthBasis: TextWidthBasis.parent,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
