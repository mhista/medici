import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';
import '../images/rounded_rect_image.dart';
import '../texts/title_subtitle.dart';

class ChatCard extends ConsumerWidget {
  const ChatCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      this.time = '',
      this.color,
      this.recent = true,
      this.isNetworkImage = false,
      required this.onPressed,
      this.isOnline = true,
      this.onCall = false,
      this.unreadMessageCount = ''});
  final String title, subTitle, image, time, unreadMessageCount;
  final Color? color;
  final bool recent, isOnline, isNetworkImage, onCall;
  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 0,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // IMAGE
              Stack(
                children: [
                  ProfileImage1(
                    isNetworkImage: isNetworkImage,
                    imageSize: 60,
                    radius: 100,
                    image: image,
                  ),
                  Positioned(
                    top: 3,
                    right: 2,
                    child: OnlineIndicator(
                      isOnline: isOnline,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              // TITLE
              Expanded(
                child: Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return TitleAndSubTitle(
                      recent: recent,
                      title: title,
                      subTitle: onCall ? 'call ongoing' : subTitle,
                    );
                  },
                ),
              ),
              // const Spacer(),
              // TRAILING
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems / 3,
                  ),
                  onCall
                      ? const Icon(
                          Iconsax.microphone,
                          color: Colors.green,
                        )
                      : Badge(
                          textColor: PColors.light,
                          backgroundColor: unreadMessageCount != ''
                              ? PColors.primary
                              : Colors.transparent,
                          label: unreadMessageCount != ''
                              ? Text(unreadMessageCount)
                              : null,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnlineIndicator extends ConsumerWidget {
  const OnlineIndicator({
    super.key,
    this.isOnline = true,
    this.size = 10,
  });
  final bool isOnline;
  final double size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Badge(
      backgroundColor: isOnline ? Colors.green : PColors.grey,
      smallSize: size,
    );
  }
}
