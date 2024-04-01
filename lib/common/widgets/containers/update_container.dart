import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class UpdateContainer extends StatelessWidget {
  const UpdateContainer({
    super.key,
    required this.child,
    this.color,
    this.width = 300,
  });
  final Widget child;
  final Color? color;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          color: color ?? PColors.primary,
          borderRadius: BorderRadius.circular(10)),
      child:
          Padding(padding: const EdgeInsets.all(PSizes.iconXs), child: child),
    );
  }
}
