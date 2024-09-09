import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/circular_images.dart';
import '../../../../common/widgets/texts/title_subtitle.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class SpecialistHeading extends StatelessWidget {
  const SpecialistHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        children: [
          const Stack(
            children: [
              MCircularImage(
                height: 100,
                width: 100,
                imageUrl: PImages.dp2,
                backgroundColor: PColors.light,
              ),
              Positioned(
                bottom: 6,
                right: -3,
                child: Icon(
                  Iconsax.verify5,
                  color: PColors.white,
                  size: 30,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 0,
                child: Icon(
                  Iconsax.verify5,
                  color: PColors.primary,
                ),
              )
            ],
          ),
          const SizedBox(
            width: PSizes.spaceBtwItems,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleAndSubTitle(
                title: "Dr. Jonny Wilson",
                subTitle: 'Dentist',
                textSize: TextSizes.large,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.location5,
                    color: PColors.primary,
                    size: 15,
                  ),
                  const SizedBox(width: PSizes.xs),
                  Text(
                    "New York, United States",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Icon(
                    Iconsax.map_15,
                    color: PColors.primary,
                    size: 15,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
