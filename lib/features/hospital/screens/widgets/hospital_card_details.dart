import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class HospitalCardDetails extends StatelessWidget {
  const HospitalCardDetails({
    super.key,
    this.increaseBy = 0,
  });
  final int increaseBy;
  @override
  Widget build(BuildContext context) {
    return Column(
      // textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Text(
          "Radient Health Care",
          style: Theme.of(context).textTheme.titleLarge!.apply(
              letterSpacingDelta: 1,
              fontWeightDelta: -1 + increaseBy,
              fontSizeDelta: increaseBy.toDouble()),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: PSizes.xs,
        ),
        Text(
          "Dental, Skin Care",
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .apply(fontSizeDelta: increaseBy.toDouble()),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: PSizes.xs + 2,
        ),
        const Divider(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Iconsax.location5,
              size: 15,
              color: PColors.primary,
            ),
            const SizedBox(
              width: PSizes.xs,
            ),
            Flexible(
              child: Text(
                "8502 Lagos Street, Mainland avenue",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(fontSizeDelta: increaseBy.toDouble()),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        const SizedBox(
          height: PSizes.xs,
        ),
        Row(
          children: [
            const Icon(
              Iconsax.clock5,
              size: 15,
              color: PColors.primary,
            ),
            const SizedBox(
              width: PSizes.xs,
            ),
            Text(
              "15 min 1.5km",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(fontSizeDelta: increaseBy.toDouble()),
            )
          ],
        )
      ],
    );
  }
}
