import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'responsive/desktop/desktop_scaffold.dart';
import 'responsive/mobile/mobile_scaffold.dart';
import 'responsive/tablet/tablet_scaffold.dart';

// import 'responsive/layout/responsive_layout.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    if (responsive.isTablet) {
      return const TabletScaffold();
    } else if (responsive.isDesktop) {
      return const DesktopScaffold();
    } else {
      return const MobileScaffold();
    }
  }
}
