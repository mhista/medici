import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/config/agora/agora_config.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';

import '../../../../common/widgets/containers/rounded_container.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/call_model.dart';

class CallButtons extends ConsumerWidget {
  const CallButtons({
    required this.engine,
    required this.call,
    super.key,
  });
  final RtcEngine engine;
  final CallModel call;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TRoundedContainer(
        margin: const EdgeInsets.only(bottom: PSizes.spaceBtwItems * 2),
        shadow: [
          BoxShadow(
              color: PColors.dark.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2)
        ],
        backgroundColor: PColors.dark.withOpacity(0.7),
        height: 70,
        width: 300,
        radius: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Icons.flip_camera_ios_outlined,
                color: ref.watch(cameraEnabled)
                    ? PColors.light
                    : PColors.light.withOpacity(0.4),
                isChanged: ref.watch(frontCameraEnabled),
                secondIcon: Icons.flip_camera_ios_sharp,
                onPressed: () {
                  if (ref.read(cameraEnabled)) {
                    AgoraEngineController.switchCamera(engine, ref);
                  }
                }),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                icon: Icons.videocam,
                color: PColors.light,
                secondIcon: Icons.videocam_off_rounded,
                isChanged: ref.watch(muteVideo),
                onPressed: () {
                  AgoraEngineController.muteUnmuteVideo(engine, ref);
                }),
            PCircularIcon(
                width: 50,
                height: 50,
                backgroundColor: Colors.red,
                icon: Iconsax.call5,
                color: PColors.light,
                onPressed: () async {
                  await AgoraEngineController.endCall(engine, ref, call);
                }),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                isChanged: ref.watch(muteAudio),
                icon: Iconsax.microphone5,
                secondIcon: Iconsax.microphone_slash5,
                color: PColors.light,
                onPressed: () {
                  AgoraEngineController.muteUnmuteAudio(engine, ref);
                }),
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
