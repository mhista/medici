import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../common/widgets/containers/container_tile.dart';
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
          ContainerTile(
            hasTrailing: true,
            useDecor: false,
            trailing: RoundedIcon(
              marginRight: 0,
              padding: 0,
              height: 30,
              width: 30,
              radius: 30,
              size: 16,
              iconData: Iconsax.video,
              isPositioned: false,
              onPressed: () {},
            ),
            title: 'Dr. Haley Lawrence',
            subTitle: 'Dermatologist',
            image: PImages.dp3,
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          // TIME
          const TimeCard()
        ],
      ),
    );
  }
}
