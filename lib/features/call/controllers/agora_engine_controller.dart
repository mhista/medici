import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medici/providers.dart';

import '../../../config/agora/agora_config.dart';
import '../models/call_model.dart';

final localUserJoinedProvider = StateProvider<bool>((ref) => false);
final remoteUserJoinedProvider = StateProvider<bool>((ref) => false);
final enableVideo = StateProvider<bool>((ref) => false);
final enableAudio = StateProvider<bool>((ref) => false);
final frontCameraEnabled = StateProvider<bool>((ref) => true);
final cameraEnabled = StateProvider<bool>((ref) => false);

class AgoraEngineController {
// initialize the enine and other dependencies

// initializes the agora engine
  static Future<void> initializeEngine(RtcEngine engine, WidgetRef ref) async {
    await engine.initialize(
      RtcEngineContext(
          appId: AgoraConfig.appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting),
    );
    ref.read(enableVideo.notifier).state = false;
    ref.read(enableAudio.notifier).state = false;
    ref.read(cameraEnabled.notifier).state = false;
  }

// join a channel
  static Future<void> joinChannel(
      CallModel callData, String token, RtcEngine engine) async {
    await engine.joinChannel(
        token: token,
        channelId: callData.callId,
        uid: 0,
        options: const ChannelMediaOptions());
  }

// renew token
  static Future<void> renewToken(String token, RtcEngine engine) async {
    await engine.renewToken(token);
  }

// enable/disable video
  static Future<void> enableDisableVideo(
      RtcEngine engine, WidgetRef ref) async {
    bool enableVid = ref.read(enableVideo);
    if (!enableVid) {
      ref.read(cameraEnabled.notifier).state = true;
      ref.read(enableVideo.notifier).state = true;
      await engine.enableVideo();
    } else {
      ref.read(cameraEnabled.notifier).state = false;

      ref.read(enableVideo.notifier).state = false;
      await engine.disableVideo();
    }
  }

// enable video
  static Future<void> enableDisableAudio(
      RtcEngine engine, WidgetRef ref) async {
    bool enableAud = ref.read(enableAudio);
    if (!enableAud) {
      ref.read(enableAudio.notifier).state = true;
      await engine.enableAudio();
    } else {
      ref.read(enableAudio.notifier).state = false;
      await engine.disableAudio();
      debugPrint('audio disable');
    }
  }

// switch camera
  static Future<void> switchCamera(RtcEngine engine, WidgetRef ref) async {
    final enabled = ref.read(cameraEnabled);
    if (enabled) {
      ref.read(frontCameraEnabled.notifier).state =
          !ref.read(frontCameraEnabled);

      await engine.switchCamera();
    }
  }

// set the default client role
  static Future<void> setClientRole(RtcEngine engine) async {
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

// start or stop the video preview
  static Future<void> startStopPreview(RtcEngine engine) async {
    await engine.startPreview();
  }

// static Future<void> setClientRole()async{}
// static Future<void> setClientRole()async{}

// callbacks for engine
  void registerEventHandler(RtcEngine engine) {
    engine.registerEventHandler(const RtcEngineEventHandler());
  }
}
