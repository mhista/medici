import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../utils/constants/colors.dart';

class PReadMoreText extends StatelessWidget {
  const PReadMoreText({
    super.key,
    required this.text,
    this.collapsedTextPrefix = "Show",
  });
  final String text;
  final String collapsedTextPrefix;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: '$collapsedTextPrefix more',
      trimExpandedText: '$collapsedTextPrefix less',
      moreStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: PColors.primary),
      lessStyle: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: PColors.primary),
    );
  }
}
