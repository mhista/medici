import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class RoundedIconContainer extends StatelessWidget {
  const RoundedIconContainer({
    super.key,
    this.child,
    this.padding = 4.0,
    this.radius = 30,
    this.marginRight = PSizes.iconXs,
    this.height,
    this.width,
  });
  final Widget? child;
  final double padding, radius, marginRight;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(right: marginRight),
      decoration: BoxDecoration(
        color: isDark ? PColors.dark : PColors.light,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(
          child: Padding(padding: EdgeInsets.all(padding), child: child)),
    );
  }
}
