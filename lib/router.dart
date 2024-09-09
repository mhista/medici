import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:medici/features/authentication/models/user_model.dart';
import 'package:medici/features/authentication/screens/login/login.dart';
import 'package:medici/features/authentication/screens/signup/signup.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
import 'package:medici/features/chat/screens/chat_room/widget/chat_call_message.dart';
import 'package:medici/features/chat/screens/messaging/all_doctors.dart';
import 'package:medici/features/checkout/screens/summary.dart';
import 'package:medici/features/hospital/screens/hospital_detail.dart';
import 'package:medici/features/main_app/screens/home/homeview.dart';
import 'package:medici/features/chat/screens/messaging/message.dart';
import 'package:medici/features/checkout/screens/add_card/add_card.dart';
import 'package:medici/features/onboarding/onboarding.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/features/specialists/screens/patient_detail.dart';

import 'features/call/screens/call_screen.dart';
import 'features/chat/screens/chat_room/chat_call_sceen.dart';
import 'features/specialists/screens/specialist_detail.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      initialLocation: '/',
      redirect: (context, state) async {
        final user = ref.watch(userProvider);

        //  Hive.
        // await HiveService.openBox("isFirstTime");
        final isFirstTime = await Hive.openBox("isFirstTime");
        bool firstTime =
            isFirstTime.get("firstTime", defaultValue: true) ?? true;

        if (firstTime) {
          return '/onBoarding';
        }
        if (user.id.isEmpty) {
          return '/login';
        }
        return null;
      },
      // refreshListenable: ,
      routes: [
        //  login
        GoRoute(
          name: 'onBoarding',
          path: '/onBoarding',
          builder: ((context, state) => const OnBoardingScreen()),
        ),
        //  login
        GoRoute(
          name: 'login',
          path: '/login',
          builder: ((context, state) => const LoginScreen()),
        ),
        //  signup
        GoRoute(
          name: 'signup',
          path: '/signup',
          builder: ((context, state) => const SignupScreen()),
        ),
        GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeView(),
            routes: [
              // chat with doctors
              GoRoute(
                  name: 'chatHolder',
                  path: 'chatHolder',
                  builder: ((context, state) {
                    return const CallChatPlaceHolder();
                  })),
              // video call a doctor
              GoRoute(
                name: 'video',
                path: 'video',
                builder: ((context, state) {
                  CallModel call = state.extra as CallModel;
                  return CallScreen(call: call);
                }),
              ),
              //  view all available doctors
              GoRoute(
                name: 'doctors',
                path: 'doctors',
                builder: ((context, state) => const AllDoctors()),
              ),
              // view by map
              GoRoute(
                path: 'map',
                builder: ((context, state) => const MessageScreen()),
              ),
              // schedule a meeting
              GoRoute(
                path: 'schedule',
                builder: ((context, state) => const MessageScreen()),
              ),

              // check all hospitals
              GoRoute(
                name: 'hospital',
                path: 'hospital',
                builder: ((context, state) {
                  return const HospitalDetail();
                }),
              ),
              // payments
              GoRoute(
                name: 'addcard',
                path: 'addcard',
                builder: ((context, state) {
                  return const AddCard();
                }),
              ),
              // summary
              GoRoute(
                name: 'payment_summary',
                path: 'payment_summary',
                builder: ((context, state) {
                  return const PaymentSummary();
                }),
              ),
              // GoRoute(
              //   name: 'success_payment',
              //   path: 'success_payment',
              //   builder: ((context, state) {
              //     return  SuccessScreen1(
              //         image: state.pathParameters["image"]!,
              //         title: state.pathParameters["title"]!,
              //         subtitle: state.pathParameters["subtitle"]!,
              //         onPressed: );
              //   }),
              // ),
              GoRoute(
                  name: 'specialist',
                  path: 'specialist',
                  builder: ((context, state) {
                    return const SpecialistDetail();
                  }),
                  routes: [
                    GoRoute(
                      name: 'patientDetail',
                      path: 'specialist/patientDetail',
                      builder: ((context, state) {
                        return const PatientDetailForm();
                      }),
                    ),
                  ]),
            ]),
      ]);
});

// implementing shell route
//  ShellRoute(

//           // path: '/',
//           // name: 'home',
//           // builder: (context, state) => const HomeView(),
//           navigatorKey: _shellNavigatorKey,
//           builder: (context, state, child) => const HomeScreen(),
//           routes: [
//             GoRoute(
//               name: 'home',
//               path: '/',
//               builder: ((context, state) {
//                 return const HomeView();
//               }),
//             ),
//             // chat with doctors
//             GoRoute(
//                 name: 'chat',
//                 path: '/chat',
//                 builder: ((context, state) {
//                   UserModel receiver = state.extra as UserModel;
//                   return ChatRoom(
//                     receiver: receiver,
//                   );
//                 }),
//                 routes: [
//                   // video call a doctor
//                   GoRoute(
//                     name: 'video',
//                     path: 'video',
//                     builder: ((context, state) {
//                       CallModel call = state.extra as CallModel;
//                       return CallScreen(call: call);
//                     }),
//                   ),
//                 ]),

//             //  view all available doctors
//             GoRoute(
//               name: 'doctors',
//               path: '/doctors',
//               builder: ((context, state) => const AllDoctors()),
//             ),
//             // view by map
//             GoRoute(
//               path: '/map',
//               builder: ((context, state) => const MessageScreen()),
//             ),
//             // schedule a meeting
//             GoRoute(
//               path: '/schedule',
//               builder: ((context, state) => const MessageScreen()),
//             ),

//             // check all hospitals
//             GoRoute(
//               name: 'hospital',
//               path: '/hospital',
//               builder: ((context, state) {
//                 return const HospitalDetail();
//               }),
//             ),
//             // payments
//             GoRoute(
//               name: 'addcard',
//               path: '/addcard',
//               builder: ((context, state) {
//                 return const AddCard();
//               }),
//             ),
//             // summary
//             GoRoute(
//               name: 'payment_summary',
//               path: '/payment_summary',
//               builder: ((context, state) {
//                 return const PaymentSummary();
//               }),
//             ),
//             // GoRoute(
//             //   name: 'success_payment',
//             //   path: 'success_payment',
//             //   builder: ((context, state) {
//             //     return  SuccessScreen1(
//             //         image: state.pathParameters["image"]!,
//             //         title: state.pathParameters["title"]!,
//             //         subtitle: state.pathParameters["subtitle"]!,
//             //         onPressed: );
//             //   }),
//             // ),
//             GoRoute(
//                 name: 'specialist',
//                 path: '/specialist',
//                 builder: ((context, state) {
//                   return const SpecialistDetail();
//                 }),
//                 routes: [
//                   GoRoute(
//                     name: 'patientDetail',
//                     path: 'specialist/patientDetail',
//                     builder: ((context, state) {
//                       return const PatientDetailForm();
//                     }),
//                   ),
//                 ]),
//           ]),
