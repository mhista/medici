import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class KRatingBarIndicator extends StatelessWidget {
  const KRatingBarIndicator({
    super.key,
    required this.rating,
    this.itemSizes = 20,
  });
  final double rating, itemSizes;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: itemSizes,
      unratedColor: PColors.grey,
      itemBuilder: (_, __) => const Icon(
        Iconsax.star1,
        color: PColors.warning,
      ),
    );
  }
}
