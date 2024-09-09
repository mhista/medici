import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/providers.dart';

import '../../../../common/widgets/badge/reviewBadge.dart';
import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/icons/positioned_icon.dart';
import '../../../../common/widgets/images/edge_rounded_images.dart';
import '../../../../router.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import 'hospital_card_details.dart';

class HospitalCard extends ConsumerWidget {
  const HospitalCard({
    super.key,
    this.width = 335,
    this.height = 280,
    required this.isFullWidth,
    this.reviewWidth = 150,
  });
  final double width, height, reviewWidth;
  final bool isFullWidth;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => ref.read(goRouterProvider).goNamed('hospital'),
      child: Padding(
          padding: const EdgeInsets.only(right: PSizes.spaceBtwItems),
          child: TRoundedContainer(
            width: width,
            height: height,
            // backgroundColor: PColors.primary,
            shadow: const [
              BoxShadow(
                color: PColors.lightGrey,
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
            child: Column(
              children: [
                Stack(
                  children: [
                    const MRoundedImage(
                      height: 335 / 2.2,
                      width: 335,
                      imageUrl: PImages.hospital1,
                      fit: BoxFit.cover,
                    ),
                    StackIcon(
                      usePositioned: true,
                      icon: Iconsax.heart,
                      onPressed: () {},
                      top: 10,
                      right: 10,
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ReviewBadge(
                          reviewWidth: reviewWidth, isFullWidth: isFullWidth),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: HospitalCardDetails(),
                )
              ],
            ),
          )),
    );
  }
}
