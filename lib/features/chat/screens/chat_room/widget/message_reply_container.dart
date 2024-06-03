import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';

class MessageReplyContainer extends StatelessWidget {
  const MessageReplyContainer({
    super.key,
    required this.messageType,
    required this.width,
    required this.text,
  });

  final String messageType, text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide(color: PColors.primary, width: 5),
          top: BorderSide(color: PColors.primary, width: 0.3),
          // bottom: BorderSide(color: PColors.primary, width: 0.5),
          right: BorderSide(color: PColors.primary, width: 0.5),
        ),
      ),
      width: messageType == MessageType.audio.name ? 200 : width,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (messageType == MessageType.audio.name)
                IconButton(
                    color: PColors.primary,
                    onPressed: () {},
                    icon: const Icon(Icons.mic_none_rounded)),
              Expanded(
                child: Text(
                  messageType == MessageType.audio.name
                      ? 'Voice message '
                      : 'You',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
          if (messageType != MessageType.audio.name)
            const SizedBox(
              height: PSizes.spaceBtwItems / 2.5,
            ),
          if (messageType != MessageType.audio.name) Text(text),
        ],
      ),
    );
  }
}
