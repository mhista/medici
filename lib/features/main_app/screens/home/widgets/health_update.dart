import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/update_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class HealthUpdate extends StatelessWidget {
  const HealthUpdate({
    super.key,
    this.color,
    required this.title,
    required this.subTitle,
    required this.iconData,
  });
  final Color? color;
  final String title, subTitle;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return UpdateContainer(
      width: 230,
      color: color,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: PColors.light,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                iconData,
                size: 30,
                color: color,
              ),
            ),
            const SizedBox(
              height: PSizes.spaceBtwSections,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(letterSpacingDelta: 3, color: PColors.dark),
            ),
            const SizedBox(
              height: PSizes.spaceBtwItems / 2,
            ),
            Text(
              subTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .apply(letterSpacingDelta: 2, color: PColors.dark),
            )
          ],
        ),
      ),
    );
  }
}
