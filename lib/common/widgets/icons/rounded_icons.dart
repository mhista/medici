import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

// class RoundedIcon extends StatelessWidget {
//   const RoundedIcon({
//     super.key,
//     this.isPositioned = false,
//     required this.iconData,
//     this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = PHelperFunctions.isDarkMode(context);

//     return ;
//   }
// }

import '../../../utils/constants/sizes.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    super.key,
    this.padding = 4.0,
    this.radius = 30,
    this.marginRight = PSizes.iconXs,
    this.height,
    this.width,
    required this.isPositioned,
    required this.iconData,
    this.size,
    this.color,
    this.hasIconColor = false,
  });
  final double padding, radius, marginRight;
  final double? height, width;
  final bool isPositioned, hasIconColor;
  final IconData iconData;
  final Color? color;
  final double? size;

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
      child: Padding(
          padding: EdgeInsets.all(padding),
          child: Stack(
            children: [
              Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    iconData,
                    size: size,
                    color: hasIconColor
                        ? color
                        : isDark
                            ? PColors.white
                            : PColors.black,
                  ),
                ),
              ),
              if (isPositioned)
                const Positioned(
                  right: 10,
                  top: 7,
                  child: Badge(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    backgroundColor: PColors.primary,
                    smallSize: 8,
                  ),
                )
            ],
          )),
    );
  }
}
