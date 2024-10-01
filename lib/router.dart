import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:medici/features/authentication/screens/login/login.dart';
import 'package:medici/features/authentication/screens/signup/signup.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/features/chat/screens/chat_room/chat_room.dart';
import 'package:medici/features/chat/screens/messaging/all_doctors.dart';
import 'package:medici/features/checkout/screens/summary.dart';
import 'package:medici/features/hospital/screens/hospital_detail.dart';
import 'package:medici/features/main_app/screens/home/homeview.dart';
import 'package:medici/features/chat/screens/messaging/message.dart';
import 'package:medici/features/checkout/screens/add_card/add_card.dart';
import 'package:medici/features/onboarding/onboarding.dart';
import 'package:medici/features/specialists/screens/patient_detail.dart';

import 'features/call/screens/call_screen.dart';
import 'features/chat/screens/AI_chat/ai_chat_room.dart';
import 'features/main_app/screens/alert_screens/success_screen.dart';
import 'features/personalization/controllers/user_controller.dart';
import 'features/specialists/screens/specialist_detail.dart';

// go route provider
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) async {
      final user = ref.watch(userProvider);
      final isFirstTimeBox = await Hive.openBox('isFirstTime');
      bool isFirstTime =
          isFirstTimeBox.get('firstTime', defaultValue: true) ?? true;

      if (isFirstTime) {
        return '/onBoarding';
      } else if (user.id.isEmpty) {
        return '/login';
      }
      return null;
    },
    routes: [
      _buildRoute(
          name: 'onBoarding',
          path: '/onBoarding',
          screen: const OnBoardingScreen()),
      _buildRoute(name: 'login', path: '/login', screen: const LoginScreen()),
      _buildRoute(
          name: 'signup', path: '/signup', screen: const SignupScreen()),
      _buildHomeRoute(),
    ],
  );
});

// route builder
GoRoute _buildRoute(
    {required String name, required String path, required Widget screen}) {
  return GoRoute(
    name: name,
    path: path,
    builder: (context, state) => screen,
  );
}

// home route builder
GoRoute _buildHomeRoute() {
  return GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => const HomeView(),
    routes: [
      _buildRoute(name: 'chat', path: 'chat', screen: const ChatRoom()),
      _buildRoute(name: 'aiChat', path: 'aiChat', screen: const AIChatRoom()),
      GoRoute(
        name: 'call',
        path: 'call',
        builder: (context, state) {
          final call = state.extra as CallModel;
          return CallScreen(call: call);
        },
      ),
      _buildRoute(name: 'doctors', path: 'doctors', screen: const AllDoctors()),
      _buildRoute(name: 'map', path: 'map', screen: const MessageScreen()),
      _buildRoute(
          name: 'schedule', path: 'schedule', screen: const MessageScreen()),
      _buildRoute(
          name: 'hospital', path: 'hospital', screen: const HospitalDetail()),
      _buildRoute(name: 'addcard', path: 'addcard', screen: const AddCard()),
      _buildRoute(
          name: 'payment_summary',
          path: 'payment_summary',
          screen: const PaymentSummary()),
      _buildRoute(
          name: 'success_payment',
          path: 'success_payment',
          screen: const SuccessScreen1()),
      _buildSpecialistRoutes(),
    ],
  );
}

// specialist routes builder
GoRoute _buildSpecialistRoutes() {
  return GoRoute(
    name: 'specialist',
    path: 'specialist',
    builder: (context, state) => const SpecialistDetail(),
    routes: [
      _buildRoute(
          name: 'patientDetail',
          path: 'specialist/patientDetail',
          screen: const PatientDetailForm()),
    ],
  );
}
