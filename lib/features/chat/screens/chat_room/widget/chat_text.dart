import 'package:flutter/material.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'chat_image_message.dart';
import 'chat_text_message.dart';

class ChatText extends StatelessWidget {
  const ChatText({
    super.key,
    required this.text,
    this.textColor,
    this.color,
    this.isUser = true,
    required this.time,
    this.width = 0,
    required this.messageType,
  });

  final String text, time, messageType;
  final Color? textColor, color;
  final bool isUser;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PSizes.spaceBtwItems, vertical: PSizes.spaceBtwItems / 2),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              messageType == MessageType.text.name
                  ?
                  // TEXT CONTAINER
                  ChatTextContainer(
                      width: width, isUser: isUser, isDark: isDark, text: text)
                  : ChatTextImage(isUser: isUser, isDark: isDark, text: text),
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
    );
  }
}
