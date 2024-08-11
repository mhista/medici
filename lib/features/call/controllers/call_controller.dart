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
import '../../../utils/constants/image_strings.dart';
import '../../chat/screens/chat_room/chat_room.dart';

final callModelProvider = StateProvider<CallModel>((ref) => CallModel.empty());
final listProvider = StateProvider<List<int>>((ref) => []);
// checks to know when the call has ended in the receivers end
final callEnded = StateProvider<bool>((ref) => true);

class CallController {
  final Ref ref;
  final CallRepository callRepository;

  CallController({required this.ref, required this.callRepository});

// CREATES A CALL DOCUMENT WHEN A CALL IS INITIATED AND IS DELETED WHEN A CALL IS ENDED OR DECLINED
  Future<void> makeCall(UserModel receiver, BuildContext context, bool isVideo,
      {bool checked = false}) async {
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
      await callRepository.makeCall(senderCallData, receiverCallData);
      FlutterRingtonePlayer().play(fromAsset: PImages.iphone1, looping: true);

      //     context.goNamed(
      //       'video',
      //       extra: senderCallData,
      //     );
      //     .then((data) {
      //   // ref.read(callModelProvider.notifier).state = senderCallData;

      //   i
      //     // schedule notification for future
      //     // NotificationService.scheduleNotification("New notification",
      //     //     "check it out", DateTime.now().add(const Duration(minutes: 10)));
      //   }
      // });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<CallModel> getCallStream() {
    return callRepository.getCallStream();
  }

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
    final isConnected = await ref.watch(networkService.notifier).isConnected();
    if (!isConnected) {
      return;
    }
    if (response.actionId == "pick") {
      final call = jsonDecode(response.payload!);
      CallModel data = CallModel.fromMap(call);
      ref.read(callEnded.notifier).state = false;
      debugPrint(ref.read(callEnded).toString());
      FlutterRingtonePlayer().stop();
      if (data.receiverId == ref.read(userProvider).id) {
        ref.read(goRouterProvider).goNamed(
              'chat',
              extra: ref.read(userProvider),
            );
      }
    }
    if (response.actionId == "decline") {
      final call = jsonDecode(response.payload!);
      CallModel data = CallModel.fromMap(call);
      endCall(data.callerId, data.receiverId, true);
    }
  }

  void endCall(String callerId, String receiverId, bool shouldPop) async {
    FlutterRingtonePlayer().stop();
    ref.read(callEnded.notifier).state = true;
    // if (receiverId == ref.read(userProvider).id) {
    //   ref.read(goRouterProvider).pop();
    // }
    debugPrint(ref.read(callEnded).toString());
    await callRepository.deleteCall(callerId, receiverId);
    ref.read(chatController).getAllUserMessages(receiverId);

    // if (shouldPop) {
    //   if (ref.read(userProvider).isOnline &&
    //       callerId == ref.read(userProvider).id) {
    //     ref.read(goRouterProvider).pop();
    //   }
    // }
    // ref.read(callModelProvider.notifier).state = CallModel.empty();
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
  return callControl.getCallStream();
});
