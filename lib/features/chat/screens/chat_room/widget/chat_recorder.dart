import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/features/chat/controllers/recorder_controller.dart';
import 'package:medici/providers.dart';

import '../../../../authentication/models/user_model.dart';
import '../../../models/message_reply.dart';

class RecorderButton extends ConsumerStatefulWidget {
  const RecorderButton({super.key, required this.receiver});
  final UserModel receiver;

  @override
  ConsumerState<RecorderButton> createState() => _RecorderButtonState();
}

class _RecorderButtonState extends ConsumerState<RecorderButton> {
  RecordingController? recordingController;
  @override
  void initState() {
    super.initState();
    _openAudio(ref);
  }

  void _openAudio(WidgetRef ref) {
    recordingController = RecordingController(ref: ref);
  }

  void startStopRecording(
      {required UserModel sender,
      required UserModel receiver,
      required MessageReply? messageReply}) {
    if (!recordingController!.isRecordingInit) {
      return;
    }
    if (!ref.read(isRecordingProvider)) {
      recordingController!.startRecording();
    } else {
      recordingController!.stopRecording(
          sender: sender, receiver: receiver, messageReply: messageReply);
    }
    ref.read(isRecordingProvider.notifier).update((state) => state = !state);
    // setState(() {

    //   isRecording = !isRecording;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final recordControler = ref.watch(recorderController);
    final messageReply = ref.watch(messageReplyProvider);

    return IconButton(
      onPressed: () {
        startStopRecording(
            sender: ref.read(userProvider),
            receiver: widget.receiver,
            messageReply: messageReply);
        ref.read(messageReplyProvider.notifier).update((state) => null);
      },
      icon: Icon(ref.watch(isRecordingProvider)
          ? Iconsax.close_circle
          : Iconsax.microphone),
    );
  }

  @override
  void dispose() {
    recordingController!.closeRecorder();

    super.dispose();
  }
}

final isRecordingProvider = StateProvider<bool>((ref) => false);
