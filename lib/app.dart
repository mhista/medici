import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'features/call/models/call_model.dart';
import 'features/personalization/controllers/user_controller.dart';
import 'utils/constants/colors.dart';
import 'utils/notification/device_notification.dart';
import 'utils/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // the notification provider
    ref.watch(notificationProvider);
    // the user provider
    final user = ref.watch(userProvider);
    // listens for when a call is made
    callCheck(ref, user);
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

  void callCheck(WidgetRef ref, UserModel user) {
    ref.watch(callProvider).whenData((data) {
      // debugPrint(data.toString());
      ref.read(callModelProvider.notifier).state = data;
      if (data.receiverId == user.id && user.isOnline) {
        // context.push(
        //   'incomingCall',
        //   extra: data,
        // );
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
        FlutterRingtonePlayer().play(fromAsset: PImages.iphone1, looping: true);
      }
      // else if (data == )
    });
  }
}
