import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/authentication/screens/signup.dart';

import '../screens/home/home.dart';
import '../../chat/screens/messaging/message.dart';
import '../screens/schedules/schedule.dart';

class NavigationController extends StateNotifier<int> {
  final screens = [
    const HomeScreen(),
    const MessageScreen(),
    const SignupScreen(),
    const ScheduleScreen(),
  ];

  NavigationController() : super(0);
  int get index => state;
  void updateState(int index) => state = index;
  // debugPrint(state.toString());
}

final navigationController = StateNotifierProvider<NavigationController, int>(
    (ref) => NavigationController());
