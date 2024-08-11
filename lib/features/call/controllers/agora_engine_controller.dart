import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medici/providers.dart';

import '../../../config/agora/agora_config.dart';
import '../../chat/screens/chat_room/chat_room.dart';
import '../models/call_model.dart';

final localUserJoinedProvider = StateProvider<bool>((ref) => false);
final remoteUserJoinedProvider = StateProvider<bool>((ref) => false);
final muteVideo = StateProvider<bool>((ref) => true);
final muteAudio = StateProvider<bool>((ref) => true);
final frontCameraEnabled = StateProvider<bool>((ref) => true);
final cameraEnabled = StateProvider<bool>((ref) => false);

class AgoraEngineController {
// initialize the enine and other dependencies

// initializes the agora engine
  static Future<void> initializeEngine(RtcEngine engine, WidgetRef ref) async {
    await engine.initialize(
      RtcEngineContext(
          appId: AgoraConfig.appId,
          channelProfile: ChannelProfileType.channelProfileCommunication),
    );
    ref.read(muteVideo.notifier).state = false;
    // ref.read(muteAudio.notifier).state = false;
    ref.read(cameraEnabled.notifier).state = false;
  }

// join a channel
  static Future<void> joinChannel(
      CallModel callData, String token, RtcEngine engine) async {
    await engine.joinChannel(
        token: token,
        channelId: callData.callId,
        uid: callData.uniqueId,
        options: const ChannelMediaOptions());
  }

// renew token
  static Future<void> renewToken(String token, RtcEngine engine) async {
    await engine.renewToken(token);
  }

  static Future<void> enableDisableVideo(RtcEngine engine) async {
    await engine.enableVideo();
  }

// mute/unmute local video
  static Future<void> muteUnmuteVideo(RtcEngine engine, WidgetRef ref) async {
    bool muteVid = ref.read(muteVideo.notifier).state = !ref.read(muteVideo);
    debugPrint(muteVid.toString());

    await engine.muteLocalVideoStream(muteVid);
    ref.read(cameraEnabled.notifier).state = muteVid;

    // debugPrint(muteVid.toString());
    // if (!muteVid) {
    //   ref.read(cameraEnabled.notifier).state = true;c
    //   ref.read(enableVideo.notifier).state = true;
    //   await engine.muteLocalVideoStream(muteVid);
    // } else {
    //   ref.read(cameraEnabled.notifier).state = false;

    //   ref.read(enableVideo.notifier).state = false;
    //   await engine.disableVideo();
    // }
  }

// mute/unmute local audio
  static Future<void> muteUnmuteAudio(RtcEngine engine, WidgetRef ref) async {
    bool muteAud = ref.read(muteAudio.notifier).state = !ref.read(muteAudio);
    debugPrint(muteAud.toString());
    await engine.muteLocalAudioStream(muteAud);
    // debugPrint(enableAud.toString());

    // if (!enableAud) {
    //   ref.read(enableAudio.notifier).state = true;
    //   await engine.enableAudio();
    // } else {
    //   ref.read(enableAudio.notifier).state = false;
    //   await engine.disableAudio();
    //   debugPrint('audio disable');
    // }
  }

// switch camera
  static Future<void> switchCamera(RtcEngine engine, WidgetRef ref) async {
    final enabled = ref.read(cameraEnabled);
    if (enabled) {
      ref.read(frontCameraEnabled.notifier).state =
          !ref.read(frontCameraEnabled);

      await engine.switchCamera();
      // await engine.setupRemoteVideo(canvas)
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

  static Future<void> endCall(
      RtcEngine engine, WidgetRef ref, CallModel call) async {
    // end the call
    ref.read(callController).endCall(call.callerId, call.receiverId, false);

    await engine.leaveChannel();
    await engine.release();
  }

// callbacks for engine
  void registerEventHandler(RtcEngine engine) {
    engine.registerEventHandler(const RtcEngineEventHandler());
  }
}
