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
import 'package:medici/features/main_app/screens/chat_room/chat_room.dart';
import 'package:medici/features/main_app/screens/home/homeview.dart';
import 'package:medici/features/main_app/screens/messaging/message.dart';

final routes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeView(), routes: [
    GoRoute(
      path: 'chat',
      builder: ((context, state) => const ChatRoom()),
    ),
    GoRoute(
      path: 'map',
      builder: ((context, state) => const MessageScreen()),
    ),
    GoRoute(
      path: 'schedule',
      builder: ((context, state) => const MessageScreen()),
    ),
  ])
]);
