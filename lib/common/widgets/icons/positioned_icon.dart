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
    this.color,
  });
  final double? left, right, top, bottom;
  final IconData icon;
  final VoidCallback onPressed;
  final bool usePositioned;
  final Color backgroundColor;
  final Color? color;

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
                color: color,
                backgroundColor: backgroundColor),
          )
        : PCircularIcon(
            onPressed: onPressed,
            height: 50,
            width: 50,
            icon: icon,
            backgroundColor: backgroundColor,
            color: color,
          );
  }
}
