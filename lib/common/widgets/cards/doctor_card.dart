import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../containers/rounded_container.dart';
import '../images/rounded_rect_image.dart';
import '../rating/rating_star.dart';
import '../texts/title_subtitle.dart';
import 'doctor_card_detail.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.image,
    this.useButton = true,
  });
  final String title, subTitle, image;
  final double rating;
  final bool useButton;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return TRoundedContainer(
      radius: 10,
      showBorder: true,
      backgroundColor: isDark ? PColors.dark : PColors.white,
      borderColor: PColors.light,
      borderWidth: 1.5,
      margin: const EdgeInsets.symmetric(horizontal: PSizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: ProfileImage1(
                    image: image,
                    imageSize: 100,
                  ),
                ),
                const SizedBox(
                  width: PSizes.spaceBtwItems,
                ),
                DoctorCardDetail(
                  title: title,
                  subTitle: subTitle,
                  rating: rating,
                ),
              ],
            ),
            if (useButton)
              Column(
                children: [
                  const SizedBox(
                    height: PSizes.sm,
                  ),
                  SizedBox(
                    width: 350,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PColors.primary.withOpacity(0.1),
                        overlayColor: PColors.primary.withOpacity(0.1),
                        foregroundColor: PColors.primary.withOpacity(0.1),
                        shadowColor: PColors.primary.withOpacity(0.1),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Book Appointment',
                        style: TextStyle(color: PColors.primary),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
