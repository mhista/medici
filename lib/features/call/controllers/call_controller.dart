import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/repositories/call_repository.dart';
import 'package:medici/features/call/screens/call_screen.dart';
import 'package:uuid/uuid.dart';

import '../../../providers.dart';

class CallController {
  final Ref ref;
  final CallRepository callRepository;
  final listProvider = StateProvider<List<int>>((ref) => []);
  CallController({required this.ref, required this.callRepository});

// CREATES A CALL DOCUMENT WHEN A CALL IS INITIATED AND IS DELETED WHEN A CALL IS ENDED OR DECLINED
  void makeCall(UserModel receiver, BuildContext context) async {
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
          uniqueId: generateUserId());
      final receiverCallData = CallModel(
          callerId: user.id,
          callerName: user.fullName,
          callerPic: user.profilePicture,
          receiverId: receiver.id,
          receiverName: receiver.fullName,
          callId: callId,
          hasDialled: false,
          uniqueId: generateUserId());
      await callRepository
          .makeCall(senderCallData, receiverCallData)
          .then((data) => context.goNamed(
                'video',
                extra: senderCallData,
              ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Stream<CallModel> getCallStream() {
    return callRepository.getCallStream();
  }

  // generate random unique id
  int generateUserId() {
    final list = ref.read(listProvider);
    var random = Random();
    int num = 100 + random.nextInt(900);
    if (list.contains(num)) {
      generateUserId();
    } else {
      list.add(num);
      ref.read(listProvider.notifier).state = list;
    }
    return num;
  }
}

final callProvider = StreamProvider((ref) {
  final callControl = ref.watch(callController);
  return callControl.getCallStream();
});
