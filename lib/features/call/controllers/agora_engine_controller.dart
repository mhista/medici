import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:medici/providers.dart';
import '../../../config/agora/agora_config.dart';
import '../models/call_model.dart';

// final localUserJoinedProvider = StateProvider<bool>((ref) => false);
// final remoteUserJoinedProvider = StateProvider<bool>((ref) => false);
final videoNotMuted = StateProvider<bool>((ref) => true);
final audioMuted = StateProvider<bool>((ref) => true);
final frontCameraEnabled = StateProvider<bool>((ref) => true);
final cameraEnabled = StateProvider<bool>((ref) => false);
final remoteUserId = StateProvider<int>((ref) => 0);
final remoteUserMuted = StateProvider<bool>((ref) => false);

class AgoraEngineController {
// initialize the enine and other dependencies

// initializes the agora engine
  static Future<void> initializeEngine(RtcEngine engine, WidgetRef ref) async {
    await engine
        .initialize(
      RtcEngineContext(
          appId: AgoraConfig.appId,
          channelProfile: ChannelProfileType.channelProfileCommunication),
    )
        .then((v) {
      debugPrint("Initializing");
    });
    ref.read(videoNotMuted.notifier).state = false;
    ref.read(audioMuted.notifier).state = false;
    ref.read(cameraEnabled.notifier).state = false;
    ref.read(remoteUserMuted.notifier).state = false;
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
  static Future<void> renewToken(
    String token,
    RtcEngine engine,
  ) async {
    await engine.renewToken(token);
  }

  static Future<void> enableDisableVideo(
      RtcEngine engine, WidgetRef ref) async {
    if (ref.watch(cameraEnabled)) {
      await engine.enableVideo();
      ref.read(videoNotMuted.notifier).state = true;
    } else {
      await engine.disableVideo();
      ref.read(videoNotMuted.notifier).state = false;
    }
  }

// mute/unmute local video
  static Future<void> muteUnmuteVideo(RtcEngine engine, WidgetRef ref) async {
    bool muteVid = ref.read(videoNotMuted);
    // debugPrint(muteVid.toString());
    debugPrint(ref.read(remoteUserId).toString());
    engine.enableLocalVideo(muteVid);
    ref.read(cameraEnabled.notifier).state = muteVid;
  }

// mute/unmute local audio
  static Future<void> muteUnmuteAudio(RtcEngine engine, WidgetRef ref) async {
    bool muteAud = ref.read(audioMuted);
    debugPrint(muteAud.toString());
    await engine.muteLocalAudioStream(muteAud);
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
    // ref.read(remoteUserMuted.notifier).state = false;

    debugPrint(call.toString());
    // end the call
    if (call.callId.isEmpty) {
      await engine.leaveChannel();
      await engine.release();
    } else {
      ref.read(callController).endCall(call.callerId, call.receiverId);
      await engine.leaveChannel();
      await engine.release();
    }
  }

// callbacks for engine
  void registerEventHandler(RtcEngine engine) {
    engine.registerEventHandler(const RtcEngineEventHandler());
  }
}
