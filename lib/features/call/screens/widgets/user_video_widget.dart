import 'package:flutter/material.dart';

import '../../../../common/widgets/images/circular_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../call_screen.dart';

class UserVideoWidget extends StatelessWidget {
  const UserVideoWidget({
    super.key,
    required this.widget,
  });

  final CallScreen widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          const SizedBox(height: PSizes.spaceBtwSections * 6),
          MCircularImage(
            imageUrl: PImages.dp2,
            isNetworkImage: false,
            height: 100,
            width: 100,
            backgroundColor: PColors.transparent,
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          Text(
            widget.call.receiverName,
            style: const TextStyle(color: PColors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PSizes.spaceBtwItems),
          const Text('Calling...'),
        ],
      ),
    );
  }
}
