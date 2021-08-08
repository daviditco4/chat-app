import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.text,
    required this.fromMe,
    this.creatorUsername,
  }) : super(key: key);

  final String text;
  final bool fromMe;
  final String? creatorUsername;

  @override
  Widget build(BuildContext context) {
    const radVal = 16.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final sch = theme.colorScheme;
    const bigRadius = Radius.circular(radVal);
    const smallRadius = Radius.circular(2.0);
    final borderRadius = BorderRadiusDirectional.only(
      topStart: bigRadius,
      topEnd: bigRadius,
      bottomStart: fromMe ? bigRadius : smallRadius,
      bottomEnd: !fromMe ? bigRadius : smallRadius,
    );
    final displayCreatorUsername = (!fromMe && creatorUsername != null);
    final textStyle = TextStyle(color: fromMe ? sch.onPrimary : sch.onSurface);

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
              : ElevationOverlay.applyOverlay(context, sch.surface, 4.0),
          borderRadius: borderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: radVal, vertical: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (displayCreatorUsername)
              Text(
                creatorUsername!,
                style: textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColorLight,
                ),
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            if (displayCreatorUsername) const SizedBox(height: 4.0),
            Text(
              text,
              style: textStyle,
              softWrap: true,
              textWidthBasis: TextWidthBasis.parent,
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
