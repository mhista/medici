import 'package:flutter/material.dart';
import 'package:medici/features/main_app/screens/home/widgets/schedule_card.dart';

class ProfileImage1 extends StatelessWidget {
  const ProfileImage1(
      {super.key,
      this.isNetworkImage = false,
      required this.image,
      this.imageSize = 50,
      this.radius = 10});
  final bool isNetworkImage;
  final String image;
  final double imageSize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: isNetworkImage
          ? null
          : Image(
              image: AssetImage(image),
              height: imageSize,
              width: imageSize,
              fit: BoxFit.contain),
    );
  }
}
