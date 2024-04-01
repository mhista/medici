import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/main_app/screens/home/responsive/common/tablet_desktop_nav.dart';

import '../../../../controller/navigation_controller.dart';

class DesktopScaffold extends ConsumerWidget {
  const DesktopScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(navigationController.notifier);

    return Scaffold(
      body: Row(
        children: [
          TabletDesktopNavigation(controller: controller),
          Expanded(child: controller.screens[ref.watch(navigationController)])
        ],
      ),
    );
  }
}
