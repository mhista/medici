import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/images/edge_rounded_images.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/texts/title_subtitle.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/specialist_model.dart';

class SpecialistHeading extends StatelessWidget {
  const SpecialistHeading({
    super.key,
    required this.doctor,
  });
  final Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Row(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MRoundedImage(
                  height: 90,
                  width: 90,
                  borderRadius: 100,
                  fit: BoxFit.fill,
                  imageUrl: doctor.profileImage,
                  backgroundColor: PColors.light,
                  isNetworkImage: true,
                ),
              ),
              const Positioned(
                bottom: 7,
                right: 8,
                child: Icon(
                  Iconsax.verify5,
                  color: PColors.white,
                  size: 30,
                ),
              ),
              const Positioned(
                bottom: 11,
                right: 11,
                child: Icon(
                  Iconsax.verify5,
                  color: PColors.primary,
                ),
              )
            ],
          ),
          const SizedBox(
            width: PSizes.spaceBtwItems,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndSubTitle(
                title: doctor.name,
                subTitle: doctor.specialty,
                textSize: TextSizes.large,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              Row(
                children: [
                  const Icon(
                    Iconsax.location5,
                    color: PColors.primary,
                    size: 15,
                  ),
                  const SizedBox(width: PSizes.xs),
                  Text(
                    doctor.location,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(width: PSizes.xs),
                  const Icon(
                    Iconsax.map_15,
                    color: PColors.primary,
                    size: 15,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
