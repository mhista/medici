import 'package:flutter/material.dart';
import 'package:medici/utils/constants/colors.dart';

import 'circular_icon.dart';

class StackIcon extends StatelessWidget {
  const StackIcon({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.icon,
    required this.onPressed,
    this.usePositioned = false,
    this.backgroundColor = PColors.white,
  });
  final double? left, right, top, bottom;
  final IconData icon;
  final VoidCallback onPressed;
  final bool usePositioned;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return usePositioned
        ? Positioned(
            top: top,
            right: right,
            left: left,
            bottom: bottom,
            child: PCircularIcon(
                onPressed: onPressed,
                height: 50,
                width: 50,
                icon: icon,
                backgroundColor: backgroundColor),
          )
        : PCircularIcon(
            onPressed: onPressed,
            height: 50,
            width: 50,
            icon: icon,
            backgroundColor: backgroundColor,
          );
  }
}
