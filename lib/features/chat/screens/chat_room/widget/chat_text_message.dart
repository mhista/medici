import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ChatTextContainer extends StatelessWidget {
  const ChatTextContainer({
    super.key,
    required this.width,
    required this.isUser,
    required this.isDark,
    required this.text,
  });

  final double width;
  final bool isUser;
  final bool isDark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: isUser
              ? PColors.primary
              : isDark
                  ? PColors.darkerGrey
                  : PColors.grey,
          border: Border.all(width: 0.02, color: Colors.grey),
          borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(15),
              topLeft: isUser ? const Radius.circular(15) : Radius.zero,
              topRight: !isUser ? const Radius.circular(15) : Radius.zero,
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
          )),
    );
  }
}

// :