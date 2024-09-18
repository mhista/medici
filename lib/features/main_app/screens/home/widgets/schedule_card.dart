import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../common/widgets/containers/container_tile.dart';
import '../../../../../common/widgets/containers/update_container.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isDark = PHelperFunctions.isDarkMode(context);

    return UpdateContainer(
      color: isDark ? PColors.darkerGrey.withOpacity(0.4) : PColors.light,
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
              backgroundColor: isDark ? PColors.dark : PColors.white,
            ),
            title: 'Dr. Haley Lawrence',
            subTitle: 'Dermatologist',
            image: PImages.dp1,
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
