import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../utils/constants/enums.dart';

class TitleAndSubTitle extends ConsumerWidget {
  const TitleAndSubTitle({
    super.key,
    this.recent = false,
    required this.title,
    this.textSize = TextSizes.small,
    required this.subTitle,
    this.useThemeColor = false,
    this.themeColor,
  });
  final String title, subTitle;
  final TextSizes textSize;
  final bool recent, useThemeColor;
  final Color? themeColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textSize == TextSizes.small
              ? Theme.of(context).textTheme.labelLarge!.apply(
                  overflow: TextOverflow.ellipsis,
                  color: useThemeColor ? themeColor : null)
              : textSize == TextSizes.medium
                  ? Theme.of(context).textTheme.bodyMedium!.apply(
                      overflow: TextOverflow.ellipsis,
                      color: useThemeColor ? themeColor : null)
                  : Theme.of(context).textTheme.titleLarge!.apply(
                        fontWeightDelta: -1,
                        overflow: TextOverflow.ellipsis,
                        color: useThemeColor ? themeColor : null,
                      ),
        ),
        const SizedBox(
          height: PSizes.spaceBtwItems / 3,
        ),
        Text(
          subTitle,
          style: textSize == TextSizes.small
              ? recent
                  ? Theme.of(context).textTheme.labelLarge!.apply(
                      overflow: TextOverflow.ellipsis,
                      color: useThemeColor ? themeColor : null)
                  : Theme.of(context).textTheme.labelMedium!.apply(
                      overflow: TextOverflow.ellipsis,
                      color: useThemeColor ? themeColor : null)
              : textSize == TextSizes.medium
                  ? Theme.of(context).textTheme.labelLarge!.apply(
                      overflow: TextOverflow.ellipsis,
                      color: useThemeColor ? themeColor : null)
                  : Theme.of(context).textTheme.bodyMedium!.apply(
                      overflow: TextOverflow.ellipsis,
                      color: useThemeColor ? themeColor : null),
        ),
      ],
    );
  }
}
