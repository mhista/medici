import 'package:flutter/material.dart';

import '../../../../../common/widgets/cards/doctor_card.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class DoctorCardList extends StatelessWidget {
  const DoctorCardList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      separatorBuilder: (_, __) => const SizedBox(height: PSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        return const DoctorCard(
          title: 'Dr Anna Baker',
          subTitle: 'Heart Surgeon Specialist',
          rating: 4.5,
          image: PImages.dp1,
        );
      },
    );
  }
}
