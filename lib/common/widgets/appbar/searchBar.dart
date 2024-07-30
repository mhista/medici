import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/device/device_utility.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

class MSearchBar extends StatelessWidget implements PreferredSizeWidget {
  const MSearchBar(
      {super.key,
      this.color,
      required this.hintText,
      this.useSuffix = false,
      this.useBorder = true,
      this.hasColor = false,
      this.radius,
      this.textFieldWidget,
      this.textController,
      this.usePrefixSuffix = false,
      this.onChanged,
      this.prefixWidget,
      this.focusNode,
      this.onTap});

  // to add the background color to tabs, wrap with material widget.
  final Color? color;
  final String hintText;
  final bool useSuffix, useBorder, hasColor, usePrefixSuffix;
  final double? radius;
  final Widget? textFieldWidget, prefixWidget;
  final TextEditingController? textController;
  final Function(String)? onChanged;
  final Function()? onTap;

  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: PSizes.spaceBtwInputFields),
      child: TextField(
        onTap: onTap,
        focusNode: focusNode,
        onChanged: onChanged,
        controller: textController,
        decoration: InputDecoration(
            fillColor: hasColor
                ? color
                : isDark
                    ? PColors.black
                    : PColors.white,
            filled: true,
            contentPadding: useSuffix
                ? const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
                : const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: useSuffix || usePrefixSuffix
                ? textFieldWidget ?? SearchIcon(isDark: isDark)
                : null,
            prefixIcon: !useSuffix ? prefixWidget : SearchIcon(isDark: isDark),
            border: inputBorder(isDark, useBorder, radius),
            focusedBorder: inputBorder(isDark, useBorder, radius),
            enabledBorder: inputBorder(isDark, useBorder, radius)),
      ),
    );
  }

  OutlineInputBorder inputBorder(bool isDark, bool useBorder, double? radius) {
    return OutlineInputBorder(
      borderSide: useBorder
          ? BorderSide(
              color: isDark ? PColors.grey.withOpacity(0.2) : PColors.grey)
          : BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(radius ?? 14.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}

class SearchIcon extends StatelessWidget {
  const SearchIcon({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Icon(
        Iconsax.search_normal_1,
        size: 20,
        // color: isDark ? PColors.black : PColors.white,

        // color: Colors.white,
      ),
    );
  }
}
