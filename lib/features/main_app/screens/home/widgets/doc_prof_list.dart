import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/chips/filter_chip.dart';
import '../../../../../utils/constants/sizes.dart';

class FliterDoctorsList extends StatelessWidget {
  const FliterDoctorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          return KFilterChip(
            iconData: Iconsax.eye4,
            text: 'Ophthamologist',
            selected: false,
            onSelected: (selected) {},
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: PSizes.spaceBtwItems,
        ),
      ),
    );
  }
}
