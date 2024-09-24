import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';
import 'package:medici/features/call/models/call_model.dart';

import '../../../providers.dart';
import '../controllers/call_controller.dart';

final localUserJoinedProvider = StateProvider<bool>((ref) => false);
final remoteUserId = StateProvider<int?>((ref) => null);
final agoraEvents = Provider((ref) {
  return AgoraEngineEvents(ref: ref, call: ref.read(callModelProvider));
});

class AgoraEngineEvents {
  AgoraEngineEvents({
    required this.ref,
    required this.call,
  }) {
    registerEvent();
  }
  final Ref ref;
  final CallModel call;
  void registerEvent() {
    ref.watch(agoraEngine).registerEventHandler(RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connect, int elapsed) {
            // show a popup message
            debugPrint('joined successfully');
            // ref.read(localUserJoinedProvider.notifier).state = true;
            // ref.read(callController).autoRedirectTimer(
            //     () => AgoraEngineController.endCall(
            //         ref.read(agoraEngine), ref, call),
            //     30);
            ref.read(localUserJoinedProvider.notifier).state = true;
            // debugPrint(ref.read(localUserJoinedProvider).toString());
            // ref.read(localUserJoinedProvider.notifier).state = false;
            // debugPrint(ref.read(localUserJoinedProvider).toString());
          },
          onUserJoined: (connection, remoteUid, elapsed) {
            // debugPrint(remoteUid.toString());
            // ref.read(remoteUserId.notifier).state = remoteUid;
            if (remoteUid > 0) {
              ref.read(remoteUserId.notifier).state = remoteUid;
            }
            debugPrint('remote user with uid $remoteUid joined successfully');
            ref.read(ringtone).stop();
          },
          onTokenPrivilegeWillExpire: (connection, token) {
            debugPrint(
                "onTokenPrivilegeWillExpire connection: ${connection.toJson()}, token: $token");
          },
          onRequestToken: (connection) async {
            debugPrint("Requesting token from server");
            String token = await getRtcToken(
                channelName: call.callId,
                role: 'publisher',
                tokenType: 'uid',
                uid: call.uniqueId.toString());
            ref.read(agoraEngine).renewToken(token);
          },
          onRemoteVideoStateChanged: (connection, uid, state, reason, elapsed) {
            debugPrint(state.value().toString());
            debugPrint(reason.name);

            if (state.value() == 0) {
              // remote users local video disabled
              ref.read(remoteUserMuted.notifier).state = true;
            }
            if (state.value() == 1 || state.value() == 2) {
              // remote users local video enabled
              ref.read(remoteUserMuted.notifier).state = false;
            }
          },
          onLeaveChannel: (RtcConnection connect, RtcStats stats) {
            debugPrint("user left channel");
            // ref.read(localUserJoinedProvider.notifier).state = false;
          },
          onConnectionStateChanged: (connection, state, reason) {
            debugPrint("$state changed  to $reason");
          },
          onError: (type, string) {
            debugPrint("error type $type occured $string");
          },
          // onRemoteVideoTrackAdded: (connection, uid, RtcRemoteVideoTrack track) {
        ));
  }

  // void onRemoteVideoTrackAdded:(RtcConnection connect, int uid, RtcRemoteVideoTrack track){}
}



      // SETUP CALLBACKS FOR RTM CLIENT
      //   _client?.onMessageReceived = (RtmMessage message, String peerId) {
      //     debugPrint("Private message from $peerId: ${message.text}");
      //   };

      //   _client?.onConnectionStateChanged2 =
      //       (RtmConnectionState state, RtmConnectionChangeReason reason) {
      //     debugPrint("Connection state changed: ${state.name} at ${reason.name}");
      //     if (state == RtmConnectionState.aborted) {
      //       _channel?.leave();
      //       _client?.logout();
      //       _client?.release();
      //     }
      //   };

      //   // SETUP CALLBACKS FOR RTM CHANNEL
      //   _channel?.onMemberJoined = (RtmChannelMember member) {};
      //   _channel?.onMemberLeft = (RtmChannelMember member) {};
      //   _channel?.onMessageReceived =
      //       (RtmMessage message, RtmChannelMember member) {
      //     debugPrint("Public Channel message from $member: ${message.text}");
      //   };
    // }