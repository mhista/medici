import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:medici/utils/device/device_utility.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

class MSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const MSearchBar({super.key});

  // to add the background color to tabs, wrap with material widget.

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Material(
      color: isDark ? PColors.black : PColors.white,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: PSizes.spaceBtwInputFields),
        child: TextField(
          decoration: InputDecoration(
              fillColor: isDark ? PColors.black : PColors.white,
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              hintText: PTexts.hintText,
              hintStyle: Theme.of(context).textTheme.labelMedium,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  color: isDark ? PColors.black : PColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  child: const Icon(
                    Iconsax.search_normal_1,
                    size: 20,
                    // color: Colors.white,
                  ),
                ),
              ),
              border: inputBorder(isDark),
              focusedBorder: inputBorder(isDark),
              enabledBorder: inputBorder(isDark)),
        ),
      ),
    );
  }

  OutlineInputBorder inputBorder(bool isDark) {
    return OutlineInputBorder(
      borderSide: BorderSide(
          color: isDark ? PColors.grey.withOpacity(0.2) : PColors.grey),
      borderRadius: const BorderRadius.all(
        Radius.circular(14.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}
