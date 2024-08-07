import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class PCircularIcon extends ConsumerWidget {
  // Custom circular icon with a backgrund

  // properties
  //Container [width, height and backgroundColor]
// Icon [size, color and onPressed]
  const PCircularIcon({
    super.key,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.width,
    this.height,
    this.onPressed,
    this.size = PSizes.lg,
    this.boxShadow,
    this.isChanged = true,
    this.secondIcon,
  });

  final IconData icon;
  final Color? color, backgroundColor;
  final double? width, height, size;
  final VoidCallback? onPressed;
  final List<BoxShadow>? boxShadow;
  final bool isChanged;
  final IconData? secondIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          boxShadow: boxShadow,
          color: backgroundColor ??
              (isDark
                  ? PColors.dark.withOpacity(0.9)
                  : PColors.light.withOpacity(0.9)),
          borderRadius: BorderRadius.circular(100)),
      child: Consumer(
        builder: (
          _,
          WidgetRef ref,
          __,
        ) {
          return IconButton(
              padding: EdgeInsets.zero,
              onPressed: onPressed,
              icon: Icon(
                isChanged ? icon : secondIcon,
                color: color,
                size: size,
              ));
        },
      ),
    );
  }
}
