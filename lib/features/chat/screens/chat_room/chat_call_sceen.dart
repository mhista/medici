    // import 'package:flutter/material.dart';
    // import 'package:flutter_riverpod/flutter_riverpod.dart';
    // import 'package:medici/features/call/controllers/call_controller.dart';
    // import 'package:medici/features/call/models/call_model.dart';
    // import 'package:medici/features/call/screens/call_screen.dart';
    // import 'package:medici/features/chat/controllers/chat_controller.dart';
    // import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
    // import 'package:medici/features/personalization/controllers/user_controller.dart';
    // import 'package:medici/providers.dart';

    // class CallChatPlaceHolder extends ConsumerWidget {
    //   const CallChatPlaceHolder({super.key});

    //   @override
    //   Widget build(BuildContext context, WidgetRef ref) {
    //     final user = ref.watch(userProvider);
    //     final receiverPickedCall = ref.watch(receiverPicked);
    //     return PopScope(
    //       canPop: false,
    //       onPopInvokedWithResult: (canPop, result) {
    //         // ref.read(callScreenPopped.notifier).state = true;
    //         ref.read(inChatRoom.notifier).state = false;
    //         if (!ref.watch(isCallOngoing)) {
    //           Navigator.of(context).pop();
    //         }
    //       },
    //       child: StreamBuilder<CallModel>(
    //           stream: ref.watch(callController).callStream,
    //           initialData: CallModel.empty(),
    //           builder: (context, snapshot) {
    //             if (snapshot.hasData &&
    //                 snapshot.data != null &&
    //                 snapshot.data != CallModel.empty()) {
    //               CallModel call = snapshot.data!;
    //               debugPrint(call.toString());

    //               if ((!call.callEnded &&
    //                       call.callerId == user.id &&
    //                       !ref.read(switchToButton) &&
    //                       !ref.read(callScreenPopped)) ||
    //                   (!call.callEnded &&
    //                       call.receiverId == user.id &&
    //                       receiverPickedCall &&
    //                       !ref.read(switchToButton) &&
    //                       !ref.read(callScreenPopped))) {
    //                 return PopScope(
    //                   canPop: ref.watch(callScreenPopped),
    //                   onPopInvokedWithResult: (didPop, result) {
    //                     // ref.read(callScreenPopped.notifier).state = true;
    //                     if (!context.mounted) return;
    //                     ref.read(callScreenPopped.notifier).state = true;
    //                     ref.read(switchToButton.notifier).state = true;
    //                   },
    //                   child: CallScreen(
    //                     call: call,
    //                   ),
    //                 );
    //               }

    //               // if (!receiverPickedCall &&
    //               //     !call.callEnded &&
    //               //     call.receiverId == user.id) {
    //               //   return CallPickupScreen(data: call);
    //               // }
    //             }
    //             // FlutterRingtonePlayer().stop();
    //             // return CallPickupScreen(data: CallModel.empty());

    //             return const ChatRoom();
    //           }),
    //     );
    //   }
    // }
