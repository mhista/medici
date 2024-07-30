import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/circular_images.dart';
import 'package:medici/config/agora/agora_config.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:http/http.dart" as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import 'widgets/call_buttons.dart';

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
    _engine = createAgoraRtcEngine();
    // create engene

    // _engine = createAgoraRtcEngine();
    // await _engine.initialize(RtcEngineContext(
    //     appId: AgoraConfig.appId,
    //     channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
    // _client = await AgoraRtmClient.createInstance(AgoraConfig.appId);

    // enable video
    // sets the engine view mode
    // _engine.setChannelProfile(ChannelProfileType.channelProfileCommunication);
    await AgoraEngineController.initializeEngine(_engine);

    // GET TOKEN
    String token = await getRtcToken(
        channelName: widget.call.callId,
        role: 'publisher',
        tokenType: 'uid',
        uid: '0');

    // LOGIN CLIENT AND ALLOW THEM TO JOIN CHANNEL
    // await _client?.login(null, widget.call.uniqueId.toString());
    // _channel = await _client?.createChannel(widget.call.callId);
    // await _channel?.join();
    await AgoraEngineController.joinChannel(widget.call.callId, token, _engine);
    await AgoraEngineController.enableDisableVideo(_engine);
    await AgoraEngineController.setClientRole(_engine);
    await AgoraEngineController.startStopPreview(_engine);

    // SETUP CALLBACKS FOR RTC ENGINE
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connect, int elapsed) {
          // show a popup message
          debugPrint('joined successfully');
          setState(() {
            _localUserJoined = true;
          });
          FlutterRingtonePlayer()
              .play(fromAsset: PImages.iphone1, looping: true);
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
              tokenType: 'uid',
              uid: '0');
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
      backgroundColor: PColors.transparent,
      body: Padding(
        padding: PSpacingStyle.paddingWithAppBarHeight,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Center(
                child: _remoteVideo(),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TRoundedContainer(
                borderColor: PColors.primary,
                backgroundColor: PColors.transparent,
                showBorder: true,
                height: 200,
                width: 130,
                child: _localUserJoined
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(PSizes.cardRadiusLg),
                        child: AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine,
                            canvas: const VideoCanvas(
                              uid: 0,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 10,
                        width: 10,
                        child: const CircularProgressIndicator.adaptive()),
              ),
            ),
            Positioned(
              bottom: 90,
              left: responsive.screenWidth / 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TRoundedContainer(
                  margin: const EdgeInsets.only(bottom: PSizes.spaceBtwItems),
                  shadow: [
                    BoxShadow(
                        color: PColors.transparent.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 2)
                  ],
                  backgroundColor: PColors.transparent.withOpacity(0.2),
                  height: 40,
                  width: 250,
                  radius: 50,
                ),
              ),
            ),
            const CallButtons()
          ],
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
    final responsive = ResponsiveBreakpoints.of(context);

    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: widget.call.callId)),
      );
    } else {
      return MCircularImage(
        imageUrl: widget.call.callerPic,
        isNetworkImage: true,
        height: responsive.screenHeight / 4,
        width: responsive.screenWidth / 2,
        backgroundColor: PColors.transparent,
      );
    }
  }
}
