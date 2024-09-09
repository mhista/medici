import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class TabHeading extends StatelessWidget {
  const TabHeading({
    super.key,
    required this.tabHead,
    this.count,
    this.hasCount = true,
    this.usePadding = true,
    this.padding,
  });
  final String tabHead;
  final int? count;
  final bool hasCount;
  final bool usePadding;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: usePadding ? const EdgeInsets.all(PSizes.md) : padding!,
      child: Row(
        children: [
          Text(tabHead, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(
            width: PSizes.xs,
          ),
          if (hasCount)
            Text("(${count!.toString()})",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(color: PColors.primary)),
        ],
      ),
    );
  }
}
