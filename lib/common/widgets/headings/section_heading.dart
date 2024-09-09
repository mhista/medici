import 'package:flutter/material.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = false,
    required this.title,
    this.buttonTitle,
    this.onPressed,
    this.action,
    this.buttonTextColor = PColors.primary,
  });
  final Color? textColor, buttonTextColor;
  final bool showActionButton;
  final String title;
  final String? buttonTitle;

  final void Function()? onPressed;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.apply(
                  color: textColor,
                  fontWeightDelta: -1,
                  fontSizeDelta: 2,
                ),
            // maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (buttonTitle != null)
            TextButton(
              onPressed: () {},
              child: Text(
                buttonTitle!,
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          if (showActionButton && buttonTitle == null) action!
        ],
      ),
    );
  }
}
