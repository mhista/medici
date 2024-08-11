import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../common/widgets/images/circular_images.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'call_screen.dart';
import 'widgets/user_video_widget.dart';

class LocalUserVideoView extends ConsumerWidget {
  const LocalUserVideoView({
    super.key,
    required RtcEngine engine,
    required int? remoteUid,
    required this.widget,
  })  : _engine = engine,
        _remoteUid = remoteUid;

  final RtcEngine _engine;
  final int? _remoteUid;
  final CallScreen widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        TRoundedContainer(
          // backgroundColor: PColors.transparent,
          child: ref.watch(muteVideo)
              ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(
                      uid: 0,
                      backgroundColor: 0xFF272727,
                      enableAlphaMask: true,
                    ),
                  ),
                )
              : TRoundedContainer(
                  backgroundColor: PColors.dark,
                  gradient: PColors.videoGradient,
                  child: UserVideoWidget(
                    widget: widget,
                    remoteUid: _remoteUid,
                  ),
                ),
        ),
        if (_remoteUid == null)
          UserVideoWidget(
            widget: widget,
            remoteUid: _remoteUid,
          )
      ],
    );
  }
}
