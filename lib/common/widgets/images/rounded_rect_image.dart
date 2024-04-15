import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medici/utils/constants/image_strings.dart';

import '../shimmer/shimmer.dart';

class ProfileImage1 extends StatelessWidget {
  const ProfileImage1(
      {super.key,
      this.isNetworkImage = false,
      required this.image,
      this.imageSize = 50,
      this.radius = 10,
      this.fit = BoxFit.fill,
      this.errorImage = PImages.dp2});
  final bool isNetworkImage;
  final String image, errorImage;
  final double imageSize;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: isNetworkImage
          ? CachedNetworkImage(
              errorWidget: (context, errorImage, _) => Image(
                  image: AssetImage(errorImage),
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.fill),
              height: imageSize,
              width: imageSize,
              imageUrl: image,
              fit: fit,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  PShimmerEffect(
                height: 60,
                width: 60,
                radius: radius,
              ),
            )
          : Image(
              image: AssetImage(image),
              height: imageSize,
              width: imageSize,
              fit: BoxFit.fill),
    );
  }
}
