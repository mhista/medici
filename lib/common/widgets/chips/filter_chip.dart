import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../icons/rounded_icons.dart';

class KFilterChip extends StatelessWidget {
  const KFilterChip({
    super.key,
    required this.iconData,
    required this.text,
    this.selected = true,
    this.onSelected,
  });

  final IconData iconData;
  final String text;
  final bool selected;
  final Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return FilterChip(
        elevation: isDark ? PSizes.exs - 2.5 : PSizes.exs - 2.4,
        pressElevation: PSizes.exs + 1,
        showCheckmark: false,
        selected: selected,
        side: BorderSide(
          width: 0.5,
          color: selected
              ? PColors.transparent
              : isDark
                  ? PColors.light.withOpacity(0.3)
                  : PColors.dark.withOpacity(0.2),
        ),
        backgroundColor: !selected ? PColors.transparent : null,
        selectedColor: isDark ? PColors.dark : PColors.light,
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 0),
        label: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: RoundedIcon(
                hasIconColor: true,
                color: PColors.primary,
                padding: 0,
                height: 30,
                width: 30,
                radius: 30,
                iconData: iconData,
                size: 16,
                isPositioned: false,
              ),
            ),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        onSelected: onSelected);
  }
}
