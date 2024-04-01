import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrientationLayout extends ConsumerWidget {
  final Widget? landscape;
  final Widget portrait;
  const OrientationLayout({this.landscape, required this.portrait, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      final orientation = MediaQuery.of(context).orientation;
      if (orientation == Orientation.landscape) {
        if (landscape != null) return landscape ?? portrait;
      }
      return portrait;
    });
  }
}
