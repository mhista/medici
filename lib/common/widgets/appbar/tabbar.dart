import 'package:flutter/material.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/device/device_utility.dart';

import '../../../utils/helpers/helper_functions.dart';

class MTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MTabBar({super.key, required this.tabs});
  final List<Widget> tabs;

  // to add the background color to tabs, wrap with material widget.

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    return Material(
      color: isDark ? PColors.black : PColors.white,
      child: TabBar(
        tabs: tabs,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        indicatorColor: PColors.primary,
        unselectedLabelColor: PColors.darkGrey,
        labelColor: isDark ? PColors.white : PColors.primary,
        padding: const EdgeInsets.only(right: 0),
        labelStyle:
            Theme.of(context).textTheme.titleLarge!.apply(fontWeightDelta: -2),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}
