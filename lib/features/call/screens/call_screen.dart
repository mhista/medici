import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/screens/call_sender_screen.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:http/http.dart" as http;

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../chat/screens/chat_room/chat_room.dart';
import 'widgets/call_buttons.dart';
import 'widgets/user_video_widget.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({required this.call, this.isGroupChat = false, super.key});

  final CallModel call;
  final bool isGroupChat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late RtcEngine _engine;
  // AgoraRtmClient? _client;
  // AgoraRtmChannel? _channel;
  int? _remoteUid;
  bool _localUserJoined = false;
  // String baseUrl = 'https://momentous-rings.pipeops.app';
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<String> getRtcToken(
      {required String channelName,
      required String role,
      required String tokenType,
      required String uid}) async {
    String baseUrl = "https://busy-camera.pipeops.app";
    final response = await http
        .get(Uri.parse('$baseUrl/rtc/$channelName/$role/$tokenType/$uid'));
    if (response.statusCode == 200) {
      debugPrint(response.body.toString());
      return jsonDecode(response.body)['rtcToken'];
    } else {
      throw Exception('Failed to get token');
    }
  }

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();
    _engine = createAgoraRtcEngine();
    // create engene
    await AgoraEngineController.initializeEngine(_engine, ref);

    // enable video
    // sets the engine view mode
    // _engine.setChannelProfile(ChannelProfileType.channelProfileCommunication);

    // GET TOKEN
    String token = await getRtcToken(
        channelName: widget.call.callId,
        role: 'publisher',
        tokenType: 'uid',
        uid: widget.call.uniqueId.toString());

    // LOGIN CLIENT AND ALLOW THEM TO JOIN CHANNEL
    // await _client?.login(null,' widget.call.uniqueId.toString()');
    // _channel = await _client?.createChannel(widget.call.callId);
    // await _channel?.join();
    await AgoraEngineController.joinChannel(widget.call, token, _engine);
    if (widget.call.isVideo) {
      // checks if its an audio or video call
      ref.read(cameraEnabled.notifier).state = true;

      await AgoraEngineController.enableDisableVideo(_engine, ref);
    } else {
      ref.read(cameraEnabled.notifier).state = false;
    }
    // await AgoraEngineController.enableDisableVideo(_engine, ref);

    // await AgoraEngineController.enableDisableAudio(_engine, ref);
    await AgoraEngineController.startStopPreview(_engine);
    await AgoraEngineController.setClientRole(_engine);

    // SETUP CALLBACKS FOR RTC ENGINE
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connect, int elapsed) {
          // show a popup message
          debugPrint('joined successfully');
          // ref.read(localUserJoinedProvider.notifier).state = true;
          ref.read(callController).autoRedirectTimer(
              () => AgoraEngineController.endCall(_engine, ref, widget.call));
          setState(() {
            _localUserJoined = true;
          });
          // debugPrint(ref.read(localUserJoinedProvider).toString());
          // ref.read(localUserJoinedProvider.notifier).state = false;
          // debugPrint(ref.read(localUserJoinedProvider).toString());
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          // debugPrint(remoteUid.toString());
          ref.read(remoteUserId.notifier).state = remoteUid;
          setState(() {
            if (remoteUid > 0) _remoteUid = remoteUid;
            debugPrint('remote user with uid $remoteUid joined successfully');
            ref.read(ringtone).stop();
          });
        },
        onTokenPrivilegeWillExpire: (connection, token) {
          debugPrint(
              "onTokenPrivilegeWillExpire connection: ${connection.toJson()}, token: $token");
        },
        onRequestToken: (connection) async {
          debugPrint("Requesting token from server");
          String token = await getRtcToken(
              channelName: widget.call.callId,
              role: 'publisher',
              tokenType: 'uid',
              uid: widget.call.uniqueId.toString());
          _engine.renewToken(token);
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
          // ref.read(localUserJoinedProvider.notifier).state = false;
        },
        onConnectionStateChanged: (connection, state, reason) {
          debugPrint("$state changed  to $reason");
        },
        onError: (type, string) {
          debugPrint("error type $type occured $string");
        },
      ),
    );

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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (canPop, smth) {
        debugPrint('tried popping');

        // ref.read(loadingCompleteProvider.notifier).state = false;
      },
      child: Scaffold(
        backgroundColor: PColors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Center(
                child: _remoteVideo(),
              ),
            ),
            if (_remoteUid != null && widget.call.isVideo)
              Padding(
                padding: PSpacingStyle.videoePadding,
                child: Align(
                  alignment: Alignment.topRight,
                  child: TRoundedContainer(
                      borderColor: PColors.primary,
                      backgroundColor: PColors.transparent,
                      showBorder: true,
                      height: 200,
                      width: 130,
                      child: _localUserJoined && widget.call.isVideo
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(PSizes.cardRadiusLg),
                              child: LocalUserVideoView(
                                  engine: _engine,
                                  remoteUid: _remoteUid,
                                  widget: widget))
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )),
                ),
              ),
            _localUserJoined
                ? CallButtons(
                    engine: _engine,
                    call: widget.call,
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: TRoundedContainer(
                      margin:
                          const EdgeInsets.only(bottom: PSizes.spaceBtwItems),
                      shadow: [
                        BoxShadow(
                            color: PColors.dark.withOpacity(0.7),
                            blurRadius: 15,
                            spreadRadius: 2)
                      ],
                      backgroundColor: PColors.transparent.withOpacity(0.2),
                      height: 70,
                      width: 300,
                      radius: 50,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _dispose() async {
    await AgoraEngineController.endCall(_engine, ref, widget.call);
  }

  Widget _remoteVideo() {
    if (_remoteUid != null &&
        !ref.watch(remoteUserMuted) &&
        widget.call.isVideo) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: widget.call.callId)),
      );
    } else {
      return !_localUserJoined ||
              ref.watch(remoteUserMuted) ||
              !widget.call.isVideo
          ? TRoundedContainer(
              backgroundColor: PColors.dark,
              gradient: PColors.videoGradient,
              child: UserVideoWidget(
                widget: widget,
                remoteUid: _remoteUid,
                call: widget.call,
              ),
            )
          : LocalUserVideoView(
              engine: _engine, remoteUid: _remoteUid, widget: widget);
    }
  }
}
