import 'package:flutter/material.dart';
import 'package:medici/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';
import '../images/rounded_rect_image.dart';
import '../texts/title_subtitle.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      this.color,
      this.recent = true,
      required this.onPressed,
      this.isOnline = true});
  final String title, subTitle, image;
  final Color? color;
  final bool recent, isOnline;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
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
                    imageSize: 60,
                    radius: 60,
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
              TitleAndSubTitle(
                recent: recent,
                title: title,
                subTitle: subTitle,
              ),
              const Spacer(),
              // TRAILING
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '11:22 am',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems / 3,
                  ),
                  const Badge(
                    textColor: PColors.light,
                    backgroundColor: PColors.primary,
                    label: Text('2'),
                    padding: EdgeInsets.symmetric(horizontal: 5),
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

class OnlineIndicator extends StatelessWidget {
  const OnlineIndicator({
    super.key,
    this.isOnline = true,
    this.size = 10,
  });
  final bool isOnline;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: isOnline ? Colors.green : PColors.grey,
      smallSize: size,
    );
  }
}
