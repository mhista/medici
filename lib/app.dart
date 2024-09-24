import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/chat/controllers/chat_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'features/personalization/controllers/user_controller.dart';
import 'utils/constants/colors.dart';
import 'utils/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(ringtone).stop();
    // the notification provider to check when there is a noification
    ref.watch(notificationProvider);
    // the user provider
    final user = ref.watch(userProvider);
    // final chatMessage = ref.watch(chatContactMessage);
    // messageNotification(ref, user);
    // listens for when a call is made
    callCheck(ref, user);
    // checks to know when one of the  user ended the call
    // _runsAfterBuild(ref);

    // endCall(ref);

    // the router provider
    final goRoute = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRoute,
      builder: (context, child) =>
          ResponsiveBreakpoints.builder(child: child!, breakpoints: [
        const Breakpoint(start: 0, end: 600, name: MOBILE),
        const Breakpoint(start: 992, end: 1200, name: TABLET),
        const Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
      ]),
      // smartManagement: SmartManagement.keepFactory,
      // initialBinding: GeneralBindiings(),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      //Scaffold(
      //
      debugShowCheckedModeBanner: false,
    );
  }

  // void messageNotification(WidgetRef ref, UserModel user) {
  //  ref.watch(chatContactProvider).whenData((data) {
  //         final userMessage = data
  //             .where(
  //               (chat) => chat.user2.id == user.id,
  //             )
  //             .toList()
  //             .first;
  //         debugPrint(userMessage.toString());
  //         if (ref.watch(inChatRoom)) {
  //           ref
  //               .read(notificationProvider)
  //               .flutterLocalNotificationsPlugin
  //               .cancel(2);
  //           return;
  //         }

  //         if (userMessage.lastMessage == "📹 Video call" ||
  //             userMessage.lastMessage == "📞 Voice call") {
  //           ref
  //               .read(notificationProvider)
  //               .flutterLocalNotificationsPlugin
  //               .cancel(2);
  //           return;
  //         }
  //         if (userMessage.user2 == user && user.isOnline) {
  //           ref.read(notificationProvider).showInstantNotification(
  //             enableLights: true,
  //             enableVibration: true,
  //             notificationId: 2,
  //             timeOutAfter: 5000,
  //             title: userMessage.user1.fullName,
  //             body: userMessage.lastMessage,
  //             ongoing: true,
  //             actionId: '1',
  //             payload: data.last.toJson(),
  //             notificationActions: [
  //               const AndroidNotificationAction('reply', 'Reply',
  //                   titleColor: PColors.primary, showsUserInterface: true),
  //             ],
  //           );
  //           // Future(()=>ref.read(chatContactMessage.notifier).state = userMessage);
  //         }
  //       });
  // }

  void callCheck(WidgetRef ref, UserModel user) {
    ref.watch(callProvider).whenData((data) {
      // debugPrint(data.toString());
      // ref.read(callModelProvider.notifier).state = data;
      if (ref.watch(inChatRoom)) {
        return;
      }
      if (data.receiverId == user.id &&
          user.isOnline &&
          data.callEnded == false) {
        ref.read(notificationProvider).showInstantNotification(
          enableLights: true,
          enableVibration: true,
          notificationId: 1,
          timeOutAfter: 50000,
          title: "Incoming call",
          body: data.isVideo
              ? "${data.callerName} is requesting a video call"
              : "${data.callerName} is requesting a voice call",
          ongoing: true,
          actionId: '1',
          payload: data.toJson(),
          notificationActions: [
            const AndroidNotificationAction('pick', 'Pick',
                titleColor: PColors.primary, showsUserInterface: true),
            const AndroidNotificationAction('decline', 'Decline',
                titleColor: PColors.primary,
                cancelNotification: true,
                showsUserInterface: true),
          ],
        );
        ref.read(ringtone).play(
            fromAsset: PImages.iphone1,
            looping: true,
            volume: 1,
            asAlarm: true);
      } else {
        // ref.read(showCallModal.notifier).state = false;
      }
    });
  }

  // _runsAfterBuild(WidgetRef ref) async {
  //   await Future(() {
  //     ref.watch(callProvider).whenData((data) async {
  //       if (data.callEnded == true &&
  //           !ref.read(channelLeft) &&
  //           data.callOngoing == false) {
  //         ref.read(callModelProvider.notifier).state = data;
  //         ref.read(isCallOngoing.notifier).state = false;

  //         await AgoraEngineController.endCall(ref.read(agoraEngine), ref, data);
  //         ref.read(callController).autoRedirectTimer(() {
  //           ref.read(engineInitialized.notifier).state = false;
  //           AgoraEngineController.release(ref.read(
  //             agoraEngine,
  //           ));
  //         }, 60);
  //       } else {
  //         ref.read(callModelProvider.notifier).state = data;
  //       }
  //     });
  //     ref.read(loadingCompleteProvider.notifier).state = true;
  //   });
  // }
}
