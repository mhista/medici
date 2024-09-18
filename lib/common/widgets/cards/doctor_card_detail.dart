import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../texts/title_subtitle.dart';

class DoctorCardDetail extends StatelessWidget {
  const DoctorCardDetail({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    this.useLongLocation = true,
    this.textSize = TextSizes.medium,
    this.useVerifiedText = true,
  });

  final String title;
  final String subTitle;
  final double rating;
  final bool useLongLocation, useVerifiedText;
  final TextSizes textSize;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndSubTitle(
          title: title,
          subTitle: subTitle,
          textSize: textSize,
        ),
        const SizedBox(
          height: PSizes.spaceBtwItems / 2.5,
        ),
        // RATING AND VERIFICATION
        Row(
          children: [
            TRoundedContainer(
              height: 30,
              width: 60,
              backgroundColor:
                  isDark ? PColors.darkerGrey.withOpacity(0.4) : PColors.light,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Iconsax.star5,
                    size: 18,
                    color: PColors.primary,
                  ),
                  const SizedBox(
                    width: PSizes.xs / 2,
                  ),
                  Text(
                    rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .apply(fontSizeDelta: -1),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: PSizes.xs,
            ),
            if (!useLongLocation)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Iconsax.location5,
                    size: 13,
                    color: PColors.grey,
                  ),
                  const SizedBox(
                    width: PSizes.xs,
                  ),
                  Flexible(
                    child: Text(
                      "850m",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .apply(color: PColors.darkGrey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            // VERIFICATION
            Row(
              children: [
                if (useVerifiedText)
                  TRoundedContainer(
                    // backgroundColor: PColors.primary.withOpacity(0.1),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(
                          Iconsax.verify5,
                          color: PColors.primary,
                          size: 20,
                        ),
                        Text(
                          'Profile Verified',
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                              overflow: TextOverflow.ellipsis,
                              color: PColors.primary),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ],
        ),
        const SizedBox(
          height: PSizes.spaceBtwItems / 2.5,
        ),
        // distance
        if (useLongLocation)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.location5,
                size: 15,
                color: PColors.grey,
              ),
              const SizedBox(
                width: PSizes.xs,
              ),
              Flexible(
                child: Text(
                  "850m from you",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: PColors.darkGrey),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
      ],
    );
  }
}
