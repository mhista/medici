// // display 2 routes
// // LOGGED OUT ROUTE
// // LOGGED IN ROUTE

// import 'package:flutter/material.dart';
// import 'package:medici/features/authentication/screens/signup.dart';
// import 'package:medici/features/main_app/screens/chat_room/chat_room.dart';
// import 'package:medici/features/main_app/screens/home/home.dart';
// import 'package:medici/features/main_app/screens/home/homeview.dart';
// import 'package:routemaster/routemaster.dart';

// final loggedOutRoute = RouteMap(
//   routes: {
//     "/": (_) => const MaterialPage(child: SignupScreen()),
//   },
// );
// final loggedInRoute = RouteMap(
//   routes: {
//     "/": (_) => const MaterialPage(
//           child: HomeView(),
//         ),
//     'chat': (routeData) => const MaterialPage(
//           child: ChatRoom(),
//         )
//   },
// );

import 'package:go_router/go_router.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
import 'package:medici/features/chat/screens/messaging/all_doctors.dart';
import 'package:medici/features/main_app/screens/home/homeview.dart';
import 'package:medici/features/chat/screens/messaging/message.dart';

import 'features/call/screens/call_screen.dart';

final routes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeView(), routes: [
    GoRoute(
        name: 'chat',
        path: 'chat',
        builder: ((context, state) {
          UserModel receiver = state.extra as UserModel;
          return ChatRoom(
            receiver: receiver,
          );
        }),
        routes: []),
    GoRoute(
      name: 'doctors',
      path: 'doctors',
      builder: ((context, state) => const AllDoctors()),
    ),
    GoRoute(
      path: 'map',
      builder: ((context, state) => const MessageScreen()),
    ),
    GoRoute(
      path: 'schedule',
      builder: ((context, state) => const MessageScreen()),
    ),
    GoRoute(
        name: 'video',
        path: 'video',
        builder: ((context, state) {
          CallModel call = state.extra as CallModel;
          return CallScreen(call: call);
        }))
  ]),
]);
