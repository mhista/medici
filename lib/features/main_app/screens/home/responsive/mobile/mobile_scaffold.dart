import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/utils/helpers/helper_functions.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../controller/navigation_controller.dart';
import '../common/tablet_mobile_navigation.dart';
import '../tablet/tablet_scaffold.dart';

class MobileScaffold extends ConsumerWidget {
  const MobileScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // CONTROLLER FOR NAVIGATING MAJOR SCREENS
    final controller = ref.watch(navigationController.notifier);

    final isDark = PHelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar:
            SmallScreenNavigation(isDark: isDark, controller: controller),
        body: controller.screens[ref.watch(navigationController)]);
  }
}
