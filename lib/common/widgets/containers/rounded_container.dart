import 'package:flutter/material.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = PSizes.cardRadiusLg,
    this.backgroundColor,
    this.borderColor,
    this.child,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.gradient,
    this.shadow,
    this.borderWidth = 1.0,
  });
  final double? width, height;
  final double radius, borderWidth;
  final Color? backgroundColor, borderColor;

  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;
  final bool showBorder;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor ??
              (isDark ? PColors.darkerGrey.withOpacity(0.3) : PColors.light),
          border: showBorder
              ? Border.all(
                  color: borderColor ??
                      (isDark
                          ? PColors.darkerGrey.withOpacity(0.4)
                          : PColors.light),
                  width: borderWidth)
              : null,
          boxShadow: shadow),
      child: child,
    );
  }
}
