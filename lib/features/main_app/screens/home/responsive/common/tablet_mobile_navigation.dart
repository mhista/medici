import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../controller/navigation_controller.dart';

class SmallScreenNavigation extends StatelessWidget {
  const SmallScreenNavigation({
    super.key,
    required this.isDark,
    required this.controller,
  });

  final bool isDark;
  final NavigationController controller;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: isDark ? PColors.black : PColors.white,
        indicatorColor: isDark
            ? PColors.white.withOpacity(0.1)
            : PColors.black.withOpacity(0.1),
        height: 80,
        elevation: 0,
        selectedIndex: controller.index,
        onDestinationSelected: (index) => controller.updateState(index),
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Iconsax.calendar), label: 'Schedule'),
          NavigationDestination(icon: Icon(Iconsax.message), label: 'Chat'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
        ]);
  }
}
