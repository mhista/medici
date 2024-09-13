import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/repositories/call_repository.dart';

import '../../../providers.dart';
import '../../../router.dart';
import '../../../utils/constants/image_strings.dart';
import '../../personalization/controllers/user_controller.dart';

final callModelProvider = StateProvider<CallModel>((ref) => CallModel.empty());
final listProvider = StateProvider<List<int>>((ref) => []);
// checks to know when the call has ended in the receivers end
final showCallModal = StateProvider<bool>((ref) => false);
final receiverPicked = StateProvider<bool>((ref) => false);
final callerId = StateProvider<String>((ref) => '');

class CallController {
  final Ref ref;
  final CallRepository callRepository;

  CallController({required this.ref, required this.callRepository});

// CREATES A CALL DOCUMENT WHEN A CALL IS INITIATED AND IS DELETED WHEN A CALL IS ENDED OR DECLINED
  void makeCall({
    required UserModel receiver,
    required BuildContext context,
    required bool isVideo,
  }) async {
    try {
      // check internet connection
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        return;
      }

      final user = ref.read(userProvider);
      var callId = const Uuid().v4();

      final senderCallData = CallModel(
          callerId: user.id,
          callerName: user.fullName,
          callerPic: user.profilePicture,
          receiverId: receiver.id,
          receiverName: receiver.fullName,
          callId: callId,
          hasDialled: true,
          isVideo: isVideo,
          uniqueId: 0,
          callEnded: false);
      final receiverCallData = CallModel(
          callerId: user.id,
          callerName: user.fullName,
          callerPic: user.profilePicture,
          receiverId: receiver.id,
          receiverName: receiver.fullName,
          callId: callId,
          hasDialled: false,
          isVideo: isVideo,
          uniqueId: 0,
          callEnded: false);
      await callRepository.makeCall(senderCallData, receiverCallData).then((v) {
        ref.read(callerId.notifier).state = senderCallData.callerId;
        if (senderCallData.callerId == ref.read(userProvider).id) {
          FlutterRingtonePlayer()
              .play(fromAsset: PImages.iphone1, looping: true);

          // ref.read(goRouterProvider).pushNamed(
          //       'video',
          //       extra: senderCallData,
          //     );
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void listenForChanges() {}

  Stream<CallModel> get callStream => callRepository.getCallStream();

  // Stream<CallModel> receiveCallStream(){}

  // generate random unique id
  int generateUserId({int numb = 0}) {
    final list = ref.read(listProvider);
    int num = numb;
    if (list.contains(num)) {
      num++;
      generateUserId(numb: num);
    } else {
      list.add(num);
      ref.read(listProvider.notifier).state = list;
    }
    return num;
  }

  void goToCallScreen(NotificationResponse response) async {
    FlutterRingtonePlayer().stop();

    final isConnected = await ref.watch(networkService.notifier).isConnected();
    if (!isConnected) {
      return;
    }
    if (response.actionId == "pick") {
      final call = jsonDecode(response.payload!);
      CallModel data = CallModel.fromMap(call);
      debugPrint(data.toString());
      if (data.receiverId == ref.read(userProvider).id) {
        if (ref.watch(userChatProvider).id.isEmpty) {
          final user =
              await ref.read(userRepository).fetchAUserData(data.callerId);
          ref.read(userChatProvider.notifier).state = user;
        }
        ref.read(receiverPicked.notifier).state = true;
        ref.read(goRouterProvider).pushNamed('chatHolder');
      }
    }
    if (response.actionId == "decline") {
      final call = jsonDecode(response.payload!);
      CallModel data = CallModel.fromMap(call);
      endCall(data.callerId, data.receiverId);
    }
  }

  void pickModelCall(CallModel data) async {
    FlutterRingtonePlayer().stop();

    final isConnected = await ref.watch(networkService.notifier).isConnected();
    if (!isConnected) {
      return;
    }

    if (data.receiverId == ref.read(userProvider).id) {
      ref.read(notificationProvider).flutterLocalNotificationsPlugin.cancel(1);
      ref.read(receiverPicked.notifier).state = true;
      // ref.read(goRouterProvider).pushNamed('chatHolder');
    }
  }

  void endCall(
    String callerId,
    String receiverId,
  ) async {
    FlutterRingtonePlayer().stop();

    await callRepository.deleteCall(callerId, receiverId);
    ref.read(receiverPicked.notifier).state = false;
  }
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

final callProvider = StreamProvider((ref) {
  final callControl = ref.watch(callController);
  return callControl.callStream;
});
