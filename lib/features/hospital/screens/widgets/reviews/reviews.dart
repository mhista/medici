import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../../common/widgets/headings/tab_headings.dart';
import '../../../../../common/widgets/rating/rating_star.dart';
import '../../../../../utils/constants/colors.dart';
import 'widgets/overall_progress_rating.dart';
import 'widgets/user_review_card.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TabHeading(
                    tabHead: 'Reviews',
                    count: 10,
                  ),
                  // ADD REVIEW HEADING
                  Padding(
                    padding: const EdgeInsets.only(right: PSizes.sm),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Iconsax.pen_add5,
                            color: PColors.primary,
                            size: 20,
                          ),
                          Text(
                            'add review',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                    overflow: TextOverflow.ellipsis,
                                    color: PColors.primary),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // REVIEWS
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.md, vertical: PSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Ratings and reviews are verified and are from peaople who use the same type of device you use'),
                    const SizedBox(
                      height: PSizes.spaceBtwItems,
                    ),

                    // OVERALL PRODUCT RATING
                    const OverAllRating(),
                    const KRatingBarIndicator(
                      rating: 4.5,
                    ),
                    Text(
                      '1300',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwSections,
                    ),
                    const UserReviewCard(),
                    const UserReviewCard(),
                  ],
                ),
              ),
            ],
          ),
        ]);
  }
}
