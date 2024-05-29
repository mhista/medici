import 'package:flutter/material.dart';

BorderRadius chatBorderRadius(bool isUser) {
  return BorderRadius.only(
      bottomLeft: const Radius.circular(15),
      topLeft: isUser ? const Radius.circular(15) : Radius.zero,
      topRight: !isUser ? const Radius.circular(15) : Radius.zero,
      bottomRight: const Radius.circular(15));
}
