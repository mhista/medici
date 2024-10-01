import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/image_strings.dart';

import '../../../utils/constants/sizes.dart';
import '../images/rounded_rect_image.dart';
import '../texts/title_subtitle.dart';

class AIChatCard extends ConsumerWidget {
  const AIChatCard(
      {super.key,
      required this.subTitle,
      this.time = '',
      this.color,
      required this.onPressed});

  final Color? color;
  final String subTitle, time;
  final VoidCallback onPressed;

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
              const Stack(
                children: [
                  ProfileImage1(
                    imageSize: 60,
                    radius: 100,
                    image: PImages.logo,
                  ),
                  Positioned(
                    top: 3,
                    right: 2,
                    child: OnlineIndicator(
                      isOnline: true,
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
                      title: 'Medini (AI assistant)',
                      subTitle: subTitle,
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
