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
  });
  final String title, subTitle;
  final TextSizes textSize;
  final bool recent;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textSize == TextSizes.small
              ? Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(overflow: TextOverflow.ellipsis)
              : Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(overflow: TextOverflow.ellipsis),
        ),
        const SizedBox(
          height: PSizes.spaceBtwItems / 3,
        ),
        Text(
          subTitle,
          style: textSize == TextSizes.small
              ? recent
                  ? Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(overflow: TextOverflow.ellipsis)
                  : Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .apply(overflow: TextOverflow.ellipsis)
              : Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
