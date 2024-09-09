import 'package:flutter/material.dart';

import 'curved_edge.dart';

class MCurvedEdgesWidget extends StatelessWidget {
  const MCurvedEdgesWidget({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: PCustomCurvedEdges(), child: child);
  }
}
