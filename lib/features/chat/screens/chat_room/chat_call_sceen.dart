import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/call/screens/call_pickup_screen.dart';
import 'package:medici/features/call/screens/call_screen.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/providers.dart';


class CallChatPlaceHolder extends ConsumerWidget {
  const CallChatPlaceHolder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final receiverPickedCall = ref.watch(receiverPicked);
    return StreamBuilder<CallModel>(
        stream: ref.watch(callController).callStream,
        initialData: CallModel.empty(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data != CallModel.empty()) {
            CallModel call = snapshot.data!;
            debugPrint(call.toString());

            if ((!call.callEnded && call.callerId == user.id) ||
                (!call.callEnded &&
                    call.receiverId == user.id &&
                    receiverPickedCall)) {
              return CallScreen(
                call: call,
              );
            }

            if (!receiverPickedCall &&
                !call.callEnded &&
                call.receiverId == user.id) {
              return CallPickupScreen(data: call);
            }
          }
          // FlutterRingtonePlayer().stop();

          return const ChatRoom();
        });
  }
}
