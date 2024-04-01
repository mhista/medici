import 'package:flutter/material.dart';
import 'package:medici/features/main_app/screens/home/widgets/schedule_card.dart';

class ProfileImage1 extends StatelessWidget {
  const ProfileImage1({
    super.key,
    this.isNetworkImage = false,
    required this.image,
    this.imageSize = 50,
  });
  final bool isNetworkImage;
  final String image;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
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
