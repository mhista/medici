import 'package:flutter/material.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../../common/widgets/headings/tab_headings.dart';

class Treatments extends StatelessWidget {
  const Treatments({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        const TabHeading(
          tabHead: 'Treatments',
          count: 18,
        ),
        ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PSizes.spaceBtwItems),
                child: ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  tileColor: PColors.light,
                  splashColor: PColors.primary.withOpacity(0.1),
                  hoverColor: PColors.primary.withOpacity(0.1),
                  focusColor: PColors.primary.withOpacity(0.1),
                  onTap: () {},
                  leading: Text(
                    "Dental",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: PColors.primary,
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
                  height: PSizes.spaceBtwItems,
                ),
            itemCount: 10)
      ],
    );
  }
}
