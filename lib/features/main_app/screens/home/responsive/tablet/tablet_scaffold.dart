import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controller/navigation_controller.dart';
import '../common/tablet_desktop_nav.dart';
import '../common/tablet_mobile_navigation.dart';

class TabletScaffold extends ConsumerWidget {
  const TabletScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ResponsiveBreakpoints.of(context);
    final controller = ref.watch(navigationController.notifier);
    final isDark = PHelperFunctions.isDarkMode(context);
    return Scaffold(
        // drawerScrimColor: isDark ? PColors.dark : PColors.light,
        appBar: AppBar(
          backgroundColor: PColors.primary,
        ),
        // DISPLAYS A DRAWER IF TABLET IS IN LANDSCAPE MODE
        drawer: responsive.orientation == Orientation.landscape
            // responsive.between('MOBTAB', TABLET)
            ? TabletDesktopNavigation(
                controller: controller,
              )
            : null,
        // DISPLAYS A BOTTOM NAVIGATION BAR IF TABLET IS IN PORTRAIT MODE

        bottomNavigationBar: responsive.orientation == Orientation.portrait
            ? SmallScreenNavigation(isDark: isDark, controller: controller)
            : null,
        body: controller.screens[ref.watch(navigationController)]);
  }
}
