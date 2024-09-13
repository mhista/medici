import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

import '../../../../controller/navigation_controller.dart';
import '../common/tablet_mobile_navigation.dart';

class MobileScaffold extends ConsumerStatefulWidget {
  const MobileScaffold({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends ConsumerState<MobileScaffold>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(userController).setUserState(true);
        // set user to online
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        ref.read(userController).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // CONTROLLER FOR NAVIGATING MAJOR SCREENS
    final controller = ref.watch(navigationController.notifier);

    final isDark = PHelperFunctions.isDarkMode(context);
    return Scaffold(
        bottomNavigationBar:
            SmallScreenNavigation(isDark: isDark, controller: controller),
        body: controller.screens[ref.watch(navigationController)]);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
