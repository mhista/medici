import 'package:flutter/material.dart';
import 'package:medici/common/widgets/shimmer/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class ChatCardShimmer extends StatelessWidget {
  const ChatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(children: [
              PShimmerEffect(
                height: 60,
                width: 60,
                radius: 60,
              ),
              SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              Column(
                children: [
                  PShimmerEffect(height: 15, width: 150),
                  SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  PShimmerEffect(height: 13, width: 120),
                ],
              ),
              SizedBox(
                width: PSizes.spaceBtwItems,
              ),
              PShimmerEffect(height: 10, width: 50),
            ]),
          );
        },
        separatorBuilder: (_, __) =>
            const SizedBox(height: PSizes.spaceBtwItems),
      ),
    );
  }
}
