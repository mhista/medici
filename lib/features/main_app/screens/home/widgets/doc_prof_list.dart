import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/common/widgets/cards/doctor_card_detail.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/images/edge_rounded_images.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../../../router.dart';
import '../../../../../utils/constants/sizes.dart';

class FilterDoctorsList extends ConsumerWidget {
  const FilterDoctorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(specialistController);
    final doctors = ref.watch(allSpecialists);
    return SizedBox(
      height: 210,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return GestureDetector(
            onTap: () {
              ref.read(specialistProvider.notifier).state = doctor;
              ref.read(goRouterProvider).goNamed("specialist");
            },
            child: TRoundedContainer(
              // borderColor: PColors.primary,
              width: 160,
              height: 100,
              showBorder: true,
              borderWidth: 0.7,
              borderColor: PColors.light,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: PSizes.xs,
                  ),
                  MRoundedImage(
                    imageUrl: doctor.profileImage,
                    width: 90,
                    height: 90,
                    borderRadius: 100,
                    fit: BoxFit.fill,
                    isNetworkImage: true,
                  ),
                  const SizedBox(
                    height: PSizes.sm,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DoctorCardDetail(
                      title: doctor.name,
                      subTitle: doctor.specialty,
                      rating: doctor.rating,
                      useVerifiedText: false,
                      useLongLocation: false,
                      textSize: TextSizes.small,
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
