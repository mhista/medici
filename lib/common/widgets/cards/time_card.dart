import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/formatters/formatter.dart';
import '../../../utils/helpers/helper_functions.dart';

class TimeCard extends StatelessWidget {
  const TimeCard({super.key, this.elevation = 1, this.color = PColors.primary});
  final double? elevation;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Card(
      elevation: elevation,
      color: isDark ? color!.withOpacity(0.1) : color!.withOpacity(0.7),
      child: Padding(
        padding: const EdgeInsets.all(PSizes.sm + 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.clock5,
              color: Colors.white.withOpacity(0.6),
            ),
            const SizedBox(
              width: PSizes.spaceBtwItems / 2,
            ),
            Flexible(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: PFormatter.formatDate(DateTime.now()),
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: PColors.white, overflow: TextOverflow.ellipsis),
                ),
                TextSpan(
                  text: ' - ${PFormatter.formatTime()}',
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: PColors.white, overflow: TextOverflow.ellipsis),
                ),
              ])),
            )
          ],
        ),
      ),
    );
  }
}
