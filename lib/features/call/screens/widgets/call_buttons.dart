import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class CallButtons extends StatelessWidget {
  const CallButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TRoundedContainer(
        margin: const EdgeInsets.only(bottom: PSizes.spaceBtwItems),
        shadow: [
          BoxShadow(
              color: PColors.transparent.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2)
        ],
        backgroundColor: PColors.transparent.withOpacity(0.3),
        height: 70,
        width: 300,
        radius: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Iconsax.document_forward5,
                color: PColors.light,
                onPressed: () {}),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Iconsax.video5,
                color: PColors.light,
                onPressed: () {}),
            PCircularIcon(
                width: 50,
                height: 50,
                backgroundColor: PColors.primary,
                icon: Iconsax.call5,
                color: PColors.light,
                onPressed: () {
                  FlutterRingtonePlayer().stop();
                }),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Iconsax.microphone5,
                color: PColors.light,
                onPressed: () {}),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Iconsax.message5,
                color: PColors.light,
                onPressed: () {
                  // FlutterRingtonePlayer().playRingtone();
                }),
          ],
        ),
      ),
    );
  }
}
