// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ResponsiveLayout extends ConsumerWidget {
//   final Widget mobileScaffold;
//   final Widget tabletScaffold;
//   final Widget desktopScaffold;
//   const ResponsiveLayout(
//       {required this.mobileScaffold,
//       required this.tabletScaffold,
//       required this.desktopScaffold,
//       super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return LayoutBuilder(builder: (context, constraints) {
//       if (constraints.maxWidth < 500) {
//         return mobileScaffold;
//       } else if (constraints.maxWidth < 1100) {
//         return tabletScaffold;
//       } else {
//         return desktopScaffold;
//       }
//     });
//   }
// }
