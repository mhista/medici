import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../common/widgets/containers/update_container.dart';
import '../../../../../common/widgets/icons/rounded_icons.dart';
import '../../../../../common/widgets/images/rounded_rect_image.dart';
import '../../../../../common/widgets/texts/title_subtitle.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return UpdateContainer(
      width: responsive.screenWidth < 700 ? double.maxFinite : 300,
      child: Column(
        children: [
          const Row(
            children: [
              // IMAGE
              ProfileImage1(
                image: PImages.dp3,
              ),
              SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              // TITLE
              TitleAndSubTitle(
                title: 'Dr. Haley Lawrence',
                subTitle: 'Dermatologist',
              ),
              Spacer(),
              // TRAILING
              RoundedIcon(
                marginRight: 0,
                padding: 0,
                height: 30,
                width: 30,
                radius: 30,
                size: 16,
                iconData: Iconsax.video,
                isPositioned: false,
              ),
            ],
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          // TIME
          Card(
            color: PColors.transparent.withOpacity(0.01),
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
                        text: 'Sun, Jan 19, 08:00am',
                        style: Theme.of(context).textTheme.labelMedium!.apply(
                            color: PColors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                      TextSpan(
                        text: ' - 10:00 am',
                        style: Theme.of(context).textTheme.labelMedium!.apply(
                            color: PColors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ])),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
