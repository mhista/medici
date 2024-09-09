import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';

class ReviewBadge extends StatelessWidget {
  const ReviewBadge({
    super.key,
    required this.reviewWidth,
    required this.isFullWidth,
    this.color = PColors.white,
    this.textColor,
    this.iconColor = PColors.warning,
  });

  final double reviewWidth;
  final bool isFullWidth;
  final Color color, iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      backgroundColor: color,
      height: 30,
      width: reviewWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.star5,
            size: 20,
            color: iconColor,
          ),
          const SizedBox(
            width: PSizes.xs / 2,
          ),
          Text(
            '4.8',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(color: textColor),
          ),
          const SizedBox(
            width: PSizes.xs / 2,
          ),
          if (isFullWidth)
            Text(
              '(1k+ Review)',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(fontSizeDelta: -1, color: textColor),
            )
        ],
      ),
    );
  }
}
