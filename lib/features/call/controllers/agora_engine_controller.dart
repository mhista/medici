import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/providers.dart';

import '../../../config/agora/agora_config.dart';

class AgoraEngineController {
  static bool _enableVideo = false;
  static bool _enableAudio = false;
// initialize the enine and other dependencies

// initializes the agora engine
  static Future<void> initializeEngine(RtcEngine engine) async {
    await engine.initialize(
      RtcEngineContext(
          appId: AgoraConfig.appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting),
    );
  }

// join a channel
  static Future<void> joinChannel(
      String channelId, String token, RtcEngine engine) async {
    await engine.joinChannel(
        token: token,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions());
  }

// renew token
  static Future<void> renewToken(String token, RtcEngine engine) async {
    await engine.renewToken(token);
  }

// enable/disable video
  static Future<void> enableDisableVideo(RtcEngine engine) async {
    _enableVideo = true;
    if (_enableVideo) {
      await engine.enableVideo();
    } else {
      await engine.disableVideo();
    }
  }

  static Future<void> enableDisableAudio(RtcEngine engine) async {
    _enableAudio = !_enableAudio;
    if (_enableAudio) {
      await engine.enableAudio();
    } else {
      await engine.disableAudio();
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
// static Future<void> setClientRole()async{}

// callbacks for engine
  void registerEventHandler(RtcEngine engine) {
    engine.registerEventHandler(const RtcEngineEventHandler());
  }
}
