import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../common/widgets/containers/container_tile.dart';
import '../../../../../common/widgets/containers/update_container.dart';
import '../../../../../common/widgets/icons/rounded_icons.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return UpdateContainer(
      color: PColors.light,
      width: responsive.screenWidth < 700 ? double.maxFinite : 300,
      child: Column(
        children: [
          ContainerTile(
            // textColor: ,
            hasTrailing: true,
            useDecor: false,
            trailing: PCircularIcon(
              height: 40,
              width: 40,
              size: 20,
              icon: Iconsax.call5,
              onPressed: () {},
              color: PColors.primary,
              backgroundColor: PColors.white,
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
