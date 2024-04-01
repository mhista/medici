import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../images/rounded_rect_image.dart';
import '../rating/rating_start.dart';
import '../texts/title_subtitle.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.rating,
    required this.reviews,
    required this.image,
  });
  final String title, subTitle, image;
  final double rating, reviews;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Card(
      color: isDark ? PColors.dark : PColors.light,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ProfileImage1(
              image: image,
              imageSize: 80,
            ),
            const SizedBox(
              width: PSizes.spaceBtwItems,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleAndSubTitle(title: title, subTitle: subTitle),
                const SizedBox(
                  height: PSizes.spaceBtwItems,
                ),
                Row(
                  children: [
                    KRatingBarIndicator(
                      rating: rating,
                      itemSizes: 17,
                    ),
                    const SizedBox(
                      width: PSizes.spaceBtwItems / 2,
                    ),
                    Text(
                      '${rating.toString()} | ${reviews.toString()} Reviews',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(fontWeightDelta: 7),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
