import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../../../common/styles/borderRadius.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ChatCallContainer extends ConsumerWidget {
  const ChatCallContainer({
    super.key,
    required this.width,
    required this.isUser,
    required this.isDark,
    required this.text,
    required this.type,
  });

  final double width;
  final bool isUser;
  final bool isDark;
  final String text, type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 180,
      // height: 70,
      decoration: BoxDecoration(
          color: isUser
              ? PColors.primary
              : isDark
                  ? PColors.darkerGrey
                  : PColors.grey,
          border: Border.all(
            width: 0.2,
          ),
          borderRadius: chatBorderRadius(isUser)),
      child: Padding(
          padding: const EdgeInsets.only(
              top: PSizes.sm,
              left: PSizes.spaceBtwItems / 2,
              right: PSizes.spaceBtwSections,
              bottom: PSizes.spaceBtwSections),
          child: Row(
            children: [
              PCircularIcon(
                  icon: type == MessageType.videoCall.name
                      ? Icons.video_call_sharp
                      : isUser
                          ? Iconsax.call_outgoing
                          : Iconsax.call_incoming),
              const SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              Column(
                children: [
                  Text(
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
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   text,
                  //   style: Theme.of(context).textTheme.bodyMedium!.apply(
                  //         color: isUser
                  //             ? PColors.white.withOpacity(0.9)
                  //             : isDark
                  //                 ? PColors.light
                  //                 : PColors.dark,
                  //       ),
                  //   // textWidthBasis: TextWidthBasis.longestLine,
                  //   softWrap: true,
                  // ),
                ],
              ),
            ],
          )),
    );
  }
}
