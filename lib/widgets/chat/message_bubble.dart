import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.text,
    required this.byMe,
    this.creatorUsername,
    this.creatorPhotoUrl,
  }) : super(key: key);

  final String text;
  final bool byMe;
  final String? creatorUsername, creatorPhotoUrl;

  @override
  Widget build(BuildContext context) {
    const creatorPhotoRadius = 20.0;
    final theme = Theme.of(context);
    final sch = theme.colorScheme;
    const verticalMarginValue = 6.0;
    final screenWidth = MediaQuery.of(context).size.width;
    const rV = 16.0;
    const bigRadius = Radius.circular(rV);
    const smallRadius = Radius.circular(2.0);
    final borderRadius = BorderRadiusDirectional.only(
      topStart: bigRadius,
      topEnd: bigRadius,
      bottomStart: byMe ? bigRadius : smallRadius,
      bottomEnd: !byMe ? bigRadius : smallRadius,
    );
    final displayCreatorUsername = (!byMe && creatorUsername != null);
    final textStyle = TextStyle(color: byMe ? sch.onPrimary : sch.onSurface);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment:
            byMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!byMe) ...[
            if (creatorPhotoUrl != null)
              CircleAvatar(
                radius: creatorPhotoRadius,
                backgroundColor: theme.primaryColorLight,
                child: Icon(Icons.person_rounded, color: sch.background),
                foregroundImage: NetworkImage(creatorPhotoUrl!),
              )
            else
              const SizedBox(width: creatorPhotoRadius * 2),
            const SizedBox(width: 12.0),
          ],
          Container(
            margin: EdgeInsets.only(
              top: verticalMarginValue,
              bottom: creatorPhotoUrl != null ? verticalMarginValue : 0.0,
            ),
            constraints: BoxConstraints(
              minWidth: screenWidth * 0.20,
              maxWidth: screenWidth * 0.75,
            ),
            decoration: BoxDecoration(
              color: byMe
                  ? theme.primaryColorDark
                  : ElevationOverlay.applyOverlay(context, sch.surface, 4.0),
              borderRadius: borderRadius,
            ),
            padding: const EdgeInsets.symmetric(horizontal: rV, vertical: 10.0),
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
        ],
      ),
    );
  }
}
