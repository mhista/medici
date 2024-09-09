import 'package:flutter/material.dart';
import 'package:medici/common/widgets/headings/tab_headings.dart';
import 'package:medici/common/widgets/images/edge_rounded_images.dart';
import 'package:medici/utils/constants/image_strings.dart';

import '../../../../../utils/constants/sizes.dart';

class GallaryView extends StatelessWidget {
  const GallaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const TabHeading(
          tabHead: 'Gallary',
          count: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: PSizes.gridViewSpacing,
              crossAxisSpacing: PSizes.gridViewSpacing,
              mainAxisExtent: 170,
            ),
            itemBuilder: (_, index) {
              return const MRoundedImage(
                imageUrl: PImages.hospital4,
                fit: BoxFit.cover,
              );
            },
          ),
        )
      ],
    );
  }
}
