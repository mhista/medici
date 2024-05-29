import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/styles/borderRadius.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class AudioPlayerWidget extends ConsumerStatefulWidget {
  const AudioPlayerWidget(
      {required this.size,
      required this.path,
      required this.isUser,
      required this.isDark,
      super.key});
  final Size size;
  final String path;
  final bool isUser;
  final bool isDark;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  late final PlayerController playerController;

  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    _prepPlayer();
    // playerController!.extractWaveformData(path: widget.path);
  }

  void _prepPlayer() async {
    await playerController!.preparePlayer(path: widget.path);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.path);
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: widget.isUser
              ? PColors.primary
              : widget.isDark
                  ? PColors.darkerGrey
                  : PColors.grey,
          border: Border.all(width: 0.02, color: Colors.grey),
          borderRadius: chatBorderRadius(widget.isUser)),
      child: Padding(
          padding: const EdgeInsets.only(
              top: PSizes.sm,
              left: PSizes.spaceBtwItems / 2,
              right: PSizes.spaceBtwSections,
              bottom: PSizes.spaceBtwSections),
          child: Row(
            children: [
              // if (!playerController!.playerState.isStopped)
              IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    playerController!.playerState.isPlaying
                        ? await playerController!.stopPlayer()
                        : await playerController!
                            .startPlayer(finishMode: FinishMode.loop);
                  },
                  icon: playerController!.playerState.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow)),
              Expanded(
                child: AudioFileWaveforms(
                  size: widget.size,
                  playerController: playerController!,
                  playerWaveStyle: const PlayerWaveStyle(
                    fixedWaveColor: Colors.white54,
                    liveWaveColor: Colors.white,
                    // spacing: 6,
                    waveCap: StrokeCap.butt,
                  ),
                ),
              )
            ],
          )),
    );
  }

  @override
  void dispose() {
    playerController!.dispose();
    super.dispose();
  }
}
