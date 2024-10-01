import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/agora_events/agora_egine_events.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/screens/call_sender_screen.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import "package:http/http.dart" as http;

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../router.dart';
import 'widgets/call_buttons.dart';
import 'widgets/user_video_widget.dart';

// screenpopped, callongoing, engineinitialized, userLeftChannel,
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
  // int? _remoteUid;
  // bool localUserJoined = false;
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
    String baseUrl = "https://rigid-produce.pipeops.app";
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
    final onGoingCall = ref.read(isCallOngoing);
    await [Permission.camera, Permission.microphone].request();

    _engine = ref.watch(agoraEngine);

    // create engene
    if (!onGoingCall) {
      await AgoraEngineController.initializeEngine(_engine, ref);
      ref.read(engineInitialized.notifier).state = true;
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
      ref.read(isCallOngoing.notifier).state = widget.call.callOngoing;
    }
    // SETUP CALLBACKS FOR RTC ENGINE
    ref.watch(agoraEvents);
  }

  @override
  Widget build(BuildContext context) {
    final remoteUid = ref.watch(remoteUserId);
    final localUserJoined = ref.watch(localUserJoinedProvider);
    _runsAfterBuild(ref);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          ref.read(goRouterProvider).goNamed('chat'),
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
            if (remoteUid != null && widget.call.isVideo)
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
                      child: localUserJoined && widget.call.isVideo
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(PSizes.cardRadiusLg),
                              child: LocalUserVideoView(
                                  engine: _engine,
                                  remoteUid: remoteUid,
                                  widget: widget))
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )),
                ),
              ),
            localUserJoined
                ? CallButtons(
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

  Widget _remoteVideo() {
    if (ref.watch(remoteUserId) != null &&
        !ref.watch(remoteUserMuted) &&
        widget.call.isVideo) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
            rtcEngine: _engine,
            canvas: VideoCanvas(uid: ref.watch(remoteUserId)),
            connection: RtcConnection(channelId: widget.call.callId)),
      );
    } else {
      return !ref.watch(localUserJoinedProvider) ||
              ref.watch(remoteUserMuted) ||
              !widget.call.isVideo
          ? TRoundedContainer(
              backgroundColor: PColors.dark,
              gradient: PColors.videoGradient,
              child: UserVideoWidget(
                widget: widget,
                remoteUid: ref.watch(remoteUserId),
                call: widget.call,
              ),
            )
          : LocalUserVideoView(
              engine: _engine,
              remoteUid: ref.watch(remoteUserId),
              widget: widget);
    }
  }

  _runsAfterBuild(WidgetRef ref) async {
    await Future(() {
      // debugPrint(ref.read(inChatRoom).toString());
      ref.watch(callProvider).whenData((data) {
        if (data.callEnded == true &&
            !ref.read(channelLeft) &&
            ref.read(isCallOngoing)) {
          ref.read(goRouterProvider).goNamed('chat');
        }
      });
    });
  }
}
