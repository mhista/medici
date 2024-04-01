import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/enums.dart';

class TitleAndSubTitle extends ConsumerWidget {
  const TitleAndSubTitle({
    super.key,
    required this.title,
    this.textSize = TextSizes.small,
    required this.subTitle,
  });
  final String title, subTitle;
  final TextSizes textSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textSize == TextSizes.small
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          subTitle,
          style: textSize == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium
              : Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
