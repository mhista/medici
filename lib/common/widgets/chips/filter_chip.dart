import 'package:flutter/material.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ButtonChip extends StatelessWidget {
  const ButtonChip({
    super.key,
    required this.iconData,
    this.text,
    this.selected = true,
    required this.onSelected,
    this.textWeight = 0,
    this.textSize = 0,
    this.spaceBtwBtn = 0,
    this.isNotSpecialist = true,
  });

  final IconData iconData;
  final String? text;
  final bool selected, isNotSpecialist;
  final Function() onSelected;
  final int textWeight, spaceBtwBtn;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    // final isDark = PHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onSelected,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 50, width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: !selected
                    ? PColors.transparent
                    : PColors.primary.withOpacity(0.1),
              ),
              // elevation: isDark ? PSizes.exs - 2.5 : PSizes.exs - 2.4,

              child: PCircularIcon(
                color: PColors.primary,
                backgroundColor: PColors.transparent,
                // height: 30,
                // width: 30,
                size: 30,
                icon: iconData,
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: (PSizes.spaceBtwItems / 2) + spaceBtwBtn,
            ),
            if (isNotSpecialist)
              Text(
                text!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall!.apply(
                    fontWeightDelta: textWeight, fontSizeDelta: textSize),
                overflow: TextOverflow.ellipsis,
              )
          ],
        ),
      ),
    );
  }
}
