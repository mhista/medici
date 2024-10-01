import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../chat_room/widget/chat_text_message.dart';
import 'ai_chat_text_container.dart';

class AIChatText extends ConsumerWidget {
  const AIChatText({
    super.key,
    required this.text,
    this.isUser = true,
    required this.time,
    this.useTime = true,
    this.width = 0,
  });

  final String text, time;
  final bool isUser, useTime;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              // GeminiResponseTypeView(builder: (context, child,text, loading){
              //     if (text != null) {
              //       return Markdown()
              //     }
              // }),
              // TEXT CONTAINER
              AIChatTextContainer(
                  width: width, isUser: isUser, isDark: isDark, text: text),
              if (useTime)
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
