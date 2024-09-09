import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/cards/doctor_card_detail.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/images/circular_images.dart';
import 'package:medici/common/widgets/images/edge_rounded_images.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:medici/utils/constants/image_strings.dart';

import '../../../../../common/widgets/chips/filter_chip.dart';
import '../../../../../router.dart';
import '../../../../../utils/constants/sizes.dart';

class FliterDoctorsList extends ConsumerWidget {
  const FliterDoctorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => ref.read(goRouterProvider).goNamed("specialist"),
            child: const TRoundedContainer(
              // borderColor: PColors.primary,
              width: 160,
              height: 100,
              showBorder: true,
              borderWidth: 0.7,
              borderColor: PColors.light,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: PSizes.xs,
                  ),
                  MRoundedImage(
                    imageUrl: PImages.dp1,
                    width: 100,
                    height: 100,
                    borderRadius: 100,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: PSizes.sm,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DoctorCardDetail(
                      title: "Dr Maria Elena",
                      subTitle: "Psychologist",
                      rating: 3.0,
                      useVerifiedText: false,
                      useLongLocation: false,
                      textSize: TextSizes.large,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: PSizes.spaceBtwItems,
        ),
      ),
    );
  }
}
