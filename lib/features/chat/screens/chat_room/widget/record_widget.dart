import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_waveforms/flutter_audio_waveforms.dart';
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
  final double size;
  final String path;
  final bool isUser;
  final bool isDark;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends ConsumerState<AudioPlayerWidget> {
  late final PlayerController playerController;
  AudioPlayer? _audioPlayer;
  List<double> _waveformData = [];
  bool _isPlaying = false;
  bool pausedPlaying = false;
  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    _audioPlayer = AudioPlayer();
    _prepPlayer();
    // playerController!.extractWaveformData(path: widget.path);
  }

  Future<void> _prepPlayer() async {
    await _audioPlayer!.setSourceUrl(widget.path);
    // setState(() {
    _waveformData = List.generate(1000, (index) => index % 10);
    // });s
    // await playerController!.preparePlayer(path: widget.path);
  }

  doSomthing() async {
    // if (_stillPlaying) {
    //   _audioPlayer!.resume();
    // }
    // setState(() {
    //   _stillPlaying = false;
    // });
  }
  // void pausePlay() {
  //   if (!pausedPlaying) {
  //     _audioPlayer!.pause();
  //   } else {
  //     _audioPlayer!.resume();
  //   }
  //   setState(() {
  //     pausedPlaying = true;
  //   });
  // }

  void startStopAudio() {
    if (!_isPlaying) {
      _audioPlayer!.play(UrlSource(widget.path));
    } else {
      _audioPlayer!.pause();
    }
    setState(() {
      _isPlaying = !_isPlaying;
      pausedPlaying = !pausedPlaying;
    });
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
              top: 0,
              left: PSizes.spaceBtwItems / 2,
              right: PSizes.spaceBtwSections,
              bottom: PSizes.xs),
          child: Row(
            children: [
              // if (!playerController!.playerState.isStopped)
              IconButton(
                  color: Colors.white,
                  onPressed: () => startStopAudio(),
                  icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow)),
              Expanded(
                  child: PolygonWaveform(
                invert: true,
                height: 2,
                samples: _waveformData,
                width: 100,
                inactiveColor: Colors.white,
                showActiveWaveform: true,
              ))
            ],
          )),
    );
  }

  @override
  void dispose() {
    _audioPlayer!.dispose();
    super.dispose();
  }
}
