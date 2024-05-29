import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

import 'package:path/path.dart' as p;

class RecordingController {
  AudioRecorder? _soundRecorder;

  final Ref ref;
  RecordState? _recordState;
  // Amplitude? _amplitude;

  RecordingController({required this.ref}) {
    // INITIALIZE THE SOUND RECORDER
    _soundRecorder = AudioRecorder();
    _recordState = RecordState.stop;
    // _amplitude = Amplitude(current: current, max: max)
    // _amplitude = _soundRecorder.onAmplitudeChanged(const Duration(milliseconds: 300)).listen((amp){

    // })
    isRecordingInit = true;
  }

  final isRecording = StateProvider<bool>((ref) => false);
  bool isRecordingInit = false;
  // prompts user for permission to access the device microphone
  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      debugPrint('not granted');
      return;
    }

    final devs = await _soundRecorder!.listInputDevices();
    debugPrint(devs.toString());
    if (await _soundRecorder!.hasPermission()) {
      // assign encoder for the audio
      const encoder = AudioEncoder.aacLc;

      // check if the encoder is supported
      if (!await _isEncoderSupported(encoder)) {
        return;
      }
      const config = RecordConfig(encoder: encoder, numChannels: 1);

      // record to a file
      await startRecording(config);

      // _startTimer()
    }
  }

// get the path
  Future<String> _getPath() async {
    final dir = await getTemporaryDirectory();
    var uuid = const Uuid().v4();
    return p.join(dir.path, 'flutter_sound_$uuid.m4a');
  }

  // check if encoder is supported
  Future<bool> _isEncoderSupported(AudioEncoder encoder) async {
    final isSupported = await _soundRecorder!.isEncoderSupported(encoder);

    if (!isSupported) {
      debugPrint('${encoder.name} is not supported on this platform.');
      debugPrint('Supported encoders are:');

      for (final e in AudioEncoder.values) {
        if (await _soundRecorder!.isEncoderSupported(e)) {
          debugPrint('- ${encoder.name}');
        }
      }
    }
    return isSupported;
  }

  Future<void> startRecording(RecordConfig config) async {
    var path = await _getPath();

    if (!isRecordingInit) {
      return;
    }
    // await _soundRecorder!.start(const RecordConfig(), path: path);

    // if (!await _soundRecorder!.isRecording()) {
    try {
      await _soundRecorder!.start(config, path: path);
      // Specify your file path or any other required parameters

      ref.read(isRecording.notifier).state = true;
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
    if (await _soundRecorder!.isRecording()) {
      try {
        final path = await _soundRecorder!.stop();
        final senderReceiver = '${sender.id}_${receiver.id}';
        ref.read(isRecording.notifier).state = false;

        if (path != null) {
          final recordedMessage = await ref
              .read(firebaseStorageHandler)
              .sendRecordFile(senderReceiver, File(path));
          ref
              .read(chatController)
              .recordMessage(receiver: receiver, path: recordedMessage);
          closeRecorder();
        }
        debugPrint(path);

        debugPrint("Recording stopped");
      } catch (e) {
        debugPrint("Error stopping recorder: $e");
      }
    } else {
      debugPrint("Recorder is not running");
    }
  }

  // close the sound recorder
  closeRecorder() async {
    isRecordingInit = false;
    // await _soundRecorder!.dispose();
  }
}
