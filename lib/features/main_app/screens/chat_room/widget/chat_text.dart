import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ChatText extends StatelessWidget {
  const ChatText({
    super.key,
    required this.text,
    this.textColor,
    this.color,
    this.isUser = true,
    required this.time,
  });

  final String text, time;
  final Color? textColor, color;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final screenWidth = PHelperFunctions.screenWidth(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: PSizes.spaceBtwItems, vertical: PSizes.spaceBtwItems / 2),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // TEXT CONTAINER
              Container(
                width: screenWidth / 1.5,
                decoration: BoxDecoration(
                    color: isUser
                        ? PColors.primary
                        : isDark
                            ? PColors.dark
                            : PColors.grey,
                    border: Border.all(width: 0.02, color: Colors.grey),
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(15),
                        topLeft:
                            isUser ? const Radius.circular(15) : Radius.zero,
                        topRight:
                            !isUser ? const Radius.circular(15) : Radius.zero,
                        bottomRight: const Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: PSizes.sm,
                      left: PSizes.spaceBtwItems / 2,
                      right: PSizes.spaceBtwSections,
                      bottom: PSizes.spaceBtwSections),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: isUser
                              ? PColors.white.withOpacity(0.9)
                              : isDark
                                  ? PColors.light
                                  : PColors.dark,
                        ),
                    // textWidthBasis: TextWidthBasis.longestLine,
                    softWrap: true,
                  ),
                ),
              ),
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
