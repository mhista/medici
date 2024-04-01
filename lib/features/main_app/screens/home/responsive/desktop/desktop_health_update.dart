import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../widgets/health_update.dart';
import '../../widgets/schedule_card.dart';

class DesktopHealthUpdate extends StatelessWidget {
  const DesktopHealthUpdate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        ScheduleCard(),
        SizedBox(
          width: PSizes.spaceBtwItems,
        ),
        HealthUpdate(
          color: Colors.lightBlue,
          title: 'HeartRate',
          subTitle: '80 BPM',
          iconData: Iconsax.heart_tick5,
        ),
        SizedBox(
          width: PSizes.spaceBtwItems,
        ),
        HealthUpdate(
          color: PColors.warning,
          title: 'Blood Pressure',
          subTitle: '120/80 mmHG',
          iconData: Iconsax.drop3,
        ),
        SizedBox(
          width: PSizes.spaceBtwItems,
        ),
        HealthUpdate(
          color: PColors.secondary,
          title: 'Glucose Level',
          subTitle: '60-80 mg',
          iconData: Icons.water_drop,
        ),
      ],
    );
  }
}
