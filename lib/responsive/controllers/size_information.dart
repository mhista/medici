import 'package:flutter/material.dart';

import 'package:medici/utils/constants/enums.dart';

class SizingInformation {
  final DeviceType? deviceType;
  final Size? screenSize;
  final Size? localWidgetSize;
  SizingInformation({
    this.deviceType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return 'SizeInformation(deviceType: $deviceType, screenSize: $screenSize, localWidgetSize: $localWidgetSize)';
  }
}
