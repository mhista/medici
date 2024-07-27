import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/providers.dart';

class RecordingController {
  RecorderController? _recorderController;
  final WidgetRef ref;

  RecordingController({required this.ref}) {
    // INITIALIZE THE SOUND RECORDER

    _recorderController = RecorderController();
    // _playerController = PlayerController();
    _openAudio();
  }

  bool isRecordingInit = false;
  // prompts user for permission to access the device microphone
  void _openAudio() async {
    if (!await _recorderController!.checkPermission()) {
      return;
    }
    isRecordingInit = true;
  }

// get the path
  Future<String> _getPath() async {
    final dir = await getTemporaryDirectory();
    var uuid = const Uuid().v4();
    return p.join(dir.path, 'flutter_sound_$uuid.m4a');
  }

  Future<void> startRecording() async {
    var path = await _getPath();

    if (!isRecordingInit) {
      return;
    }
    debugPrint(isRecordingInit.toString());

    // await _soundRecorder!.start(const RecordConfig(), path: path);

    // if (!await _soundRecorder!.isRecording()) {
    try {
      await _recorderController!.record(path: path);
      // Specify your file path or any other required parameters

      debugPrint("Recording started");
    } catch (e) {
      debugPrint("Error starting recorder: $e");
    }
    // } else {
    //   debugPrint("Recorder is already running or not in a stopped state");
    // }
  }

  Future<void> stopRecording(
      {required UserModel sender,
      required UserModel receiver,
      required MessageReply? messageReply}) async {
    if (!isRecordingInit) {
      return;
    }
    // if (_recorderController!.isRecording) {
    try {
      final path = await _recorderController!.stop();
      final senderReceiver = '${sender.id}_${receiver.id}';

      if (path != null) {
        final recordedMessage = await ref
            .read(firebaseStorageHandler)
            .sendRecordFile(senderReceiver, File(path));
        ref.read(chatController).recordMessage(
            receiver: receiver, path: recordedMessage, messageReply: null);
      }
      debugPrint(path);

      debugPrint("Recording stopped");
    } catch (e) {
      debugPrint("Error stopping recorder: $e");
    }
    // } else {
    //   debugPrint("Recorder is not running");
    // }
  }

  // close the sound recorder
  closeRecorder() async {
    isRecordingInit = false;
    _recorderController!.dispose();
  }
}
