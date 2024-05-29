import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/features/chat/controllers/recorder_controller.dart';
import 'package:medici/providers.dart';

import '../../../../authentication/models/user_model.dart';

// class RecorderButton extends StatefulWidget {
//   const RecorderButton({
//     super.key,
//   });

//   @override
//   State<RecorderButton> createState() => _RecorderButtonState();
// }

// class _RecorderButtonState extends State<RecorderButton> {
//   @override
//   Widget build(BuildContext context) {
//     final recordController = ref.watch(recorderController);
//     return Consumer(
//       builder: (_, WidgetRef ref, __) {
//         return ref.watch(recordController.isRecording)
//             ? IconButton(
//                 onPressed: () => recordController.stopRecording(),
//                 icon: const Icon(Iconsax.close_circle))
//             : IconButton(
//                 onPressed: () => recordController.startRecording(),
//                 icon: const Icon(Iconsax.microphone));
//       },
//     );
//     // onPressed: () => recordController.startRecording(),
//     // icon: const Icon(Iconsax.microphone));
//   }
// }

class RecorderButton extends ConsumerStatefulWidget {
  const RecorderButton({super.key, required this.user});
  final UserModel user;

  @override
  ConsumerState<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends ConsumerState<RecorderButton> {
  RecordingController? recordingController;
  bool isRecording = false;
  @override
  void initState() {
    super.initState();
    _openAudio(ref);
  }

  void _openAudio(WidgetRef ref) {
    recordingController = RecordingController(ref: ref);
  }

  void startStopRecording(
      {required UserModel sender, required UserModel receiver}) {
    if (!recordingController!.isRecordingInit) {
      return;
    }
    if (!isRecording) {
      recordingController!.startRecording();
    } else {
      recordingController!.stopRecording(sender: sender, receiver: receiver);
    }
    setState(() {
      isRecording = !isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final recordControler = ref.watch(recorderController);

    return IconButton(
      onPressed: () => startStopRecording(
          sender: ref.read(userProvider), receiver: widget.user),
      icon: Icon(isRecording ? Iconsax.close_circle : Iconsax.microphone),
    );
  }

  @override
  void dispose() {
    recordingController!.closeRecorder();

    super.dispose();
  }
}
