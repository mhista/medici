import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/repositories/call_repository.dart';
import 'package:medici/features/call/screens/call_screen.dart';
import 'package:medici/utils/notification/device_notification.dart';
import 'package:uuid/uuid.dart';

import '../../../providers.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class CallController {
  final Ref ref;
  final CallRepository callRepository;
  final listProvider = StateProvider<List<int>>((ref) => []);

  CallController({required this.ref, required this.callRepository});

// CREATES A CALL DOCUMENT WHEN A CALL IS INITIATED AND IS DELETED WHEN A CALL IS ENDED OR DECLINED
  void makeCall(UserModel receiver, BuildContext context, bool isVideo,
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
          uniqueId: 0);
      final receiverCallData = CallModel(
          callerId: user.id,
          callerName: user.fullName,
          callerPic: user.profilePicture,
          receiverId: receiver.id,
          receiverName: receiver.fullName,
          callId: callId,
          hasDialled: false,
          isVideo: isVideo,
          uniqueId: 0);
      await callRepository
          .makeCall(senderCallData, receiverCallData)
          .then((data) {
        if (senderCallData.callerId == user.id) {
          context.goNamed(
            'video',
            extra: senderCallData,
          );

          // schedule notification for future
          // NotificationService.scheduleNotification("New notification",
          //     "check it out", DateTime.now().add(const Duration(minutes: 10)));
        } else if (senderCallData.receiverId == user.id) {
          context.goNamed(
            'incomingCall',
            extra: senderCallData,
          );
        }
      });
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

  void goToCallScreen(NotificationResponse response) {
    if (response.actionId == "pick") {
      final call = jsonDecode(response.payload!);
      CallModel data = CallModel.fromMap(call);
      ref.read(goRouterProvider).goNamed(
            'video',
            extra: data,
          );
    }
  }

  // factory CallController.goTo(CallModel data) {
  //   ref.read(goRouterProvider).goNamed(
  //         'video',
  //         extra: data,
  //       );
  //   return null;
  // }
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
