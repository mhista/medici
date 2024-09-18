import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';

import '../../../../common/loaders/loaders.dart';
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
                color: call.isVideo
                    ? PColors.light
                    : PColors.light.withOpacity(0.4),
                secondIcon: Icons.videocam_off_rounded,
                isChanged: ref.watch(videoNotMuted),
                onPressed: () {
                  if (call.isVideo) {
                    final muted = ref.read(videoNotMuted.notifier).state =
                        !ref.read(videoNotMuted);
                    AgoraEngineController.muteUnmuteVideo(engine, ref);
                    // if (muted) {
                    //    PLoaders.customToast(
                    //     context: context, message: 'User disabled camera');
                    // } else {
                    //    PLoaders.customToast(
                    //     context: context, message: 'User enabled camera');
                    // }

                    debugPrint(ref.read(videoNotMuted).toString());
                  }
                }),
            PCircularIcon(
                width: 50,
                height: 50,
                backgroundColor: Colors.red,
                icon: Iconsax.call5,
                color: PColors.light,
                onPressed: () async {
                  ref.read(loadingCompleteProvider.notifier).state = false;
                  await AgoraEngineController.endCall(engine, ref, call);
                }),
            PCircularIcon(
                backgroundColor: PColors.transparent,
                isChanged: ref.watch(audioMuted),
                icon: Iconsax.microphone_slash5,
                secondIcon: Iconsax.microphone5,
                color: PColors.light,
                onPressed: () {
                  ref.read(audioMuted.notifier).state = !ref.read(audioMuted);
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
