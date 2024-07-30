import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class AgoraEngineEvents {
// when the local user joins the channel successfully
  void onJoinChannelSuccess(RtcConnection connect, int elapsed) {}
  // when the remote user joins the channel successfully
  void onUserJoined(RtcConnection connect, int userId, int elapsed) {}
  // when the remote user leaves the channel
  void onUserLeft(RtcConnection connect, int userId, int elapsed) {}
  // when the user's network quality is lost
  void onConnectionLost(RtcConnection connect) {}
  // when the user's network quality is interrupted
  void onConnectionInterrupted(RtcConnection connect) {}
  // when a token request is made
  void onError(ErrorCodeType type, String string) {}
  void onRequestToken(String token) {}
  // when the token is about to expire, you need to generate a new token
  void onTokenWillExpire(RtcConnection connect) {}
  // when the token is expired
  void onTokenExpired(RtcConnection connect) {}
  // when the user's local video is published
  void onFirstRemoteVideoDecoded(
      RtcConnection connect, int uid, int width, int height, int elapsed) {}
  // when the user's remote video is muted
  void onUserMuteVideo(RtcConnection connect, int userId, bool muted) {}
  // when the user's remote audio is published
  void onUserMuteAudio(RtcConnection connect, int userId, bool muted) {}
  // when the user's video state changes
  void onRemoteVideoStateChanged(
      RtcConnection connect, int uid, RemoteVideoState state) {}
  void onRemoteAudioStateChanged(
      RtcConnection connect, int uid, RemoteAudioState state) {}
  // void onRemoteVideoTrackAdded(RtcConnection connect, int uid, RtcRemoteVideoTrack track){}
}
