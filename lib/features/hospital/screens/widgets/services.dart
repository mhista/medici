import 'package:flutter/material.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/images/circular_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    super.key,
    required this.imageUrl,
    required this.text,
  });

  final String imageUrl, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(5),
          backgroundColor: PColors.primary.withOpacity(0.04),
          child: MCircularImage(
            imageUrl: imageUrl,
            width: 45,
            height: 45,
            overLayColor: PColors.primary,
          ),
        ),
        const SizedBox(
          height: PSizes.md,
        ),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .apply(fontSizeDelta: 3.5),
        )
      ],
    );
  }
}
