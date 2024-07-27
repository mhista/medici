import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/config/agora/agora_config.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:permission_handler/permission_handler.dart';

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
  // String baseUrl = 'https://momentous-rings.pipeops.app';
  @override
  void initState() {
    super.initState();
  }

  Future<void> initAgora() async {
    await [Permission.camera, Permission.microphone].request();
    // create engene
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
        appId: AgoraConfig.appId,
        channelProfile: ChannelProfileType.channelProfileCommunication));
    _client = await AgoraRtmClient.createInstance(AgoraConfig.appId);

    // enable video
    await _engine.enableVideo();
    // sets the engine view mode
    // _engine.setChannelProfile(ChannelProfileType.channelProfileCommunication);
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    // SETUP CALLBACKS FOR RTC ENGINE
    _engine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connect, int elapsed) {
      // show a popup message
    }));

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
    // _channel.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox());
  }
}
