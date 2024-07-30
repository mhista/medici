import 'package:flutter/material.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';

class TRoundedContainer extends StatelessWidget {
  const TRoundedContainer({
    super.key,
    this.width,
    this.height,
    this.radius = PSizes.cardRadiusLg,
    this.backgroundColor = PColors.white,
    this.borderColor = PColors.borderPrimary,
    this.child,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.gradient,
    this.shadow,
  });
  final double? width, height;
  final double radius;
  final Color backgroundColor, borderColor;
  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;
  final bool showBorder;
  final Gradient? gradient;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: showBorder ? Border.all(color: borderColor) : null,
          boxShadow: shadow),
      child: child,
    );
  }
}
