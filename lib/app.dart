import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'utils/constants/colors.dart';
import 'utils/notification/device_notification.dart';
import 'utils/theme/theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationProvider);
    final user = ref.watch(userProvider);
    ref.watch(callProvider).whenData((data) {
      if (data.receiverId == user.id) {
        // context.push(
        //   'incomingCall',
        //   extra: data,
        // );
        ref.read(notificationProvider).showInstantNotification(
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
      }
    });
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
}
