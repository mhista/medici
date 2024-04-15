import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

import '../../../../controller/navigation_controller.dart';
import '../common/tablet_mobile_navigation.dart';

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

class AppCIRCLE extends ConsumerStatefulWidget {
  const AppCIRCLE({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppCIRCLEState();
}

class _AppCIRCLEState extends ConsumerState<AppCIRCLE>
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
        // set user to online
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:

        // offline
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void setUserState(bool state) async {
    await ref
        .watch(firestoreProvider)
        .collection('Users')
        .doc(ref.read(firebaseAuthProvider).currentUser?.uid)
        .update({'isOnline': state});
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
