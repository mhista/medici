import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/chat/screens/chat_room/widget/record_widget.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'chat_call_message.dart';
import 'chat_image_message.dart';
import 'chat_text_message.dart';
import 'message_reply_container.dart';

class ChatText extends ConsumerWidget {
  const ChatText({
    super.key,
    required this.text,
    this.textColor,
    this.color,
    this.isUser = true,
    required this.time,
    this.width = 0,
    required this.messageType,
    required this.repliedText,
    required this.repliedMessageType,
    required this.onLeftSwipe,
    required this.username,
    required this.onRightSwipe,
  });

  final String text,
      time,
      messageType,
      repliedText,
      repliedMessageType,
      username;
  final Color? textColor, color;
  final bool isUser;
  final double width;
  final VoidCallback onLeftSwipe, onRightSwipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return SwipeTo(
      iconSize: 28,
      rightSwipeWidget: const Icon(
        Icons.reply,
        color: PColors.primary,
      ),
      leftSwipeWidget: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onLeftSwipe: (details) => onLeftSwipe(),
      onRightSwipe: (details) => onRightSwipe(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PSizes.spaceBtwItems,
            vertical: PSizes.spaceBtwItems / 2),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if ((repliedText.isNotEmpty && username.isNotEmpty))
              MessageReplyContainer(
                messageType: repliedMessageType,
                width: width,
                text: repliedText,
              ),
            Stack(
              children: [
                messageType == MessageType.text.name
                    ?
                    // TEXT CONTAINER
                    ChatTextContainer(
                        width: width,
                        isUser: isUser,
                        isDark: isDark,
                        text: text)
                    : messageType == MessageType.audio.name
                        ? AudioPlayerWidget(
                            size: width,
                            path: text,
                            isUser: isUser,
                            isDark: isDark,
                          )
                        : messageType == MessageType.videoCall.name ||
                                messageType == MessageType.voiceCall.name
                            ? ChatCallContainer(
                                width: width,
                                isUser: isUser,
                                isDark: isDark,
                                text: text,
                                type: messageType)
                            : ChatTextImage(
                                isUser: isUser, isDark: isDark, text: text),
                Positioned(
                  bottom: 4,
                  right: 7,
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: isUser
                              ? PColors.white.withOpacity(0.9)
                              : isDark
                                  ? PColors.light
                                  : PColors.dark,
                        ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
