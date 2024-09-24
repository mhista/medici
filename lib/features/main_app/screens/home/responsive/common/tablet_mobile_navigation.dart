import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../chat/controllers/chat_controller.dart';
import '../../../../controller/navigation_controller.dart';

class SmallScreenNavigation extends ConsumerWidget {
  const SmallScreenNavigation({
    super.key,
    required this.isDark,
    required this.controller,
  });

  final bool isDark;
  final NavigationController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              // Badge(
              //     backgroundColor: PColors.primary,
              //     isLabelVisible:
              //         ref.watch(unreadMessageCount) != null ? true : false,
              //     label: ref.watch(unreadMessageCount) != null
              //         ? Text(ref.watch(unreadMessageCount).toString())
              //         : null,
              //     child:
              icon: Icon(Iconsax.message),
              label: 'Chat'),
          NavigationDestination(icon: Icon(Iconsax.location), label: 'Find'),
          NavigationDestination(
              icon: Icon(Iconsax.calendar), label: 'Schedule'),
        ]);
  }
}
