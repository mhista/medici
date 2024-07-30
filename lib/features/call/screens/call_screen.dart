import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/config/agora/agora_config.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:http/http.dart" as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/containers/rounded_container.dart';

class CallScreen extends ConsumerStatefulWidget {
  const CallScreen({required this.call, this.isGroupChat = false, super.key});

  final CallModel call;
  final bool isGroupChat;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
  late RtcEngine _engine;
  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;
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
    String baseUrl = "https://momentous-rings.pipeops.app";
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
    // create engene
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
        appId: AgoraConfig.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    // _client = await AgoraRtmClient.createInstance(AgoraConfig.appId);

    // enable video
    // sets the engine view mode
    // _engine.setChannelProfile(ChannelProfileType.channelProfileCommunication);
    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.startPreview();

    // GET TOKEN
    String token = await getRtcToken(
        channelName: widget.call.callId,
        role: 'publisher',
        tokenType: 'uid',
        uid: widget.call.uniqueId.toString());

    // LOGIN CLIENT AND ALLOW THEM TO JOIN CHANNEL
    // await _client?.login(null, widget.call.uniqueId.toString());
    // _channel = await _client?.createChannel(widget.call.callId);
    // await _channel?.join();
    await _engine.joinChannel(
        token: token,
        channelId: widget.call.callId,
        uid: 0,
        options: const ChannelMediaOptions());

    // SETUP CALLBACKS FOR RTC ENGINE
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connect, int elapsed) {
          // show a popup message
          debugPrint('joined successfully');
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          setState(() {
            _remoteUid = remoteUid;
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
              tokenType: 'userAccount',
              uid: widget.call.uniqueId.toString());
          _engine.renewToken(token);
        },
        onLeaveChannel: (RtcConnection connect, RtcStats stats) {},
        onConnectionStateChanged: (connection, state, reason) {
          debugPrint("$state changed  to $reason");
        },
        onError: (type, string) {
          debugPrint("error type ${type} occured $string");
        },
      ),
    );

    // SETUP CALLBACKS FOR RTM CLIENT
    _client?.onMessageReceived = (RtmMessage message, String peerId) {
      debugPrint("Private message from $peerId: ${message.text}");
    };

    _client?.onConnectionStateChanged2 =
        (RtmConnectionState state, RtmConnectionChangeReason reason) {
      debugPrint("Connection state changed: ${state.name} at ${reason.name}");
      if (state == RtmConnectionState.aborted) {
        _channel?.leave();
        _client?.logout();
        _client?.release();
      }
    };

    // SETUP CALLBACKS FOR RTM CHANNEL
    _channel?.onMemberJoined = (RtmChannelMember member) {};
    _channel?.onMemberLeft = (RtmChannelMember member) {};
    _channel?.onMessageReceived =
        (RtmMessage message, RtmChannelMember member) {
      debugPrint("Public Channel message from $member: ${message.text}");
    };
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PSpacingStyle.paddingWithAppBarHeight,
          child: Stack(
            children: [
              Center(
                child: _remoteVideo(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: 150,
                  width: 100,
                  child: _localUserJoined
                      ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                      : Container(
                          height: 10,
                          width: 10,
                          child: const CircularProgressIndicator.adaptive()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: widget.call.callId)),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
