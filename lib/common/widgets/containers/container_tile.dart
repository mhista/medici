import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../images/rounded_rect_image.dart';
import '../texts/title_subtitle.dart';

class ContainerTile extends StatelessWidget {
  const ContainerTile(
      {super.key,
      this.trailing,
      this.hasTrailing = false,
      required this.title,
      required this.subTitle,
      required this.image,
      this.useDecor = true,
      this.color});
  final Widget? trailing;
  final bool hasTrailing, useDecor;
  final String title, subTitle, image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: useDecor
          ? BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: Row(
        children: [
          // IMAGE
          ProfileImage1(
            image: image,
          ),
          const SizedBox(
            width: PSizes.spaceBtwItems,
          ),
          // TITLE
          TitleAndSubTitle(
            title: title,
            subTitle: subTitle,
          ),
          const Spacer(),
          // TRAILING
          if (hasTrailing) trailing!
        ],
      ),
    );
  }
}
