import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/chips/filter_chip.dart';
import '../../../../../utils/constants/sizes.dart';

class FilterDoctorsList2 extends ConsumerWidget {
  const FilterDoctorsList2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return ButtonChip(
            iconData: Icons.heart_broken,
            onSelected: () {},
            text: 'Cardiologist',
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: PSizes.spaceBtwItems,
        ),
      ),
    );
  }
}
