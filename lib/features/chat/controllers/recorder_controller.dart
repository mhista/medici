import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/providers.dart';

class RecordingController {
  AudioRecorder? _soundRecorder;
  RecorderController? _recorderController;
  PlayerController? _playerController;
  final WidgetRef ref;
  RecordState? _recordState;
  // Amplitude? _amplitude;

  RecordingController({required this.ref}) {
    // INITIALIZE THE SOUND RECORDER
    _soundRecorder = AudioRecorder();
    _recordState = RecordState.stop;
    _recorderController = RecorderController();
    // _playerController = PlayerController();
    _openAudio();
  }

  bool isRecordingInit = false;
  // prompts user for permission to access the device microphone
  void _openAudio() async {
    // final status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
    //   debugPrint('not granted');
    //   return;
    // }

    // final devs = await _soundRecorder!.listInputDevices();
    // debugPrint(devs.toString());
    if (!await _recorderController!.checkPermission()) {
      // assign encoder for the audio
      // const encoder = AudioEncoder.aacLc;

      // check if the encoder is supported
      // if (!await _isEncoderSupported(encoder)) {
      //   return;
      // }
      // const config = RecordConfig(encoder: encoder, numChannels: 1);

      // record to a file
      // await startRecording();
      return;

      // _startTimer()
    }
    isRecordingInit = true;
  }

// get the path
  Future<String> _getPath() async {
    final dir = await getTemporaryDirectory();
    var uuid = const Uuid().v4();
    return p.join(dir.path, 'flutter_sound_$uuid.m4a');
  }

  // check if encoder is supported
  // Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
  //   final isSupported = await _soundRecorder!.isEncoderSupported(encoder);

  //   if (!isSupported) {
  //     debugPrint('${encoder.name} is not supported on this platform.');
  //     debugPrint('Supported encoders are:');

  //     for (final e in AudioEncoder.values) {
  //       if (await _soundRecorder!.isEncoderSupported(e)) {
  //         debugPrint('- ${encoder.name}');
  //       }
  //     }
  //   }
  //   return isSupported;
  // }

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
      {required UserModel sender, required UserModel receiver}) async {
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
        ref
            .read(chatController)
            .recordMessage(receiver: receiver, path: recordedMessage);
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
