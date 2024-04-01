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
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 4,
      scrollDirection: Axis.vertical,
      separatorBuilder: (_, __) =>
          const SizedBox(height: PSizes.spaceBtwItems / 2),
      itemBuilder: (_, index) {
        return const DoctorCard(
          title: 'Dr Anna Baker',
          subTitle: 'Heart Surgeon Specialist',
          rating: 4.5,
          reviews: 120,
          image: PImages.dp1,
        );
      },
    );
  }
}
