import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../personalization/screens/profile.dart';
import '../screens/home/home.dart';
import '../screens/messaging/message.dart';
import '../screens/schedules/schedule.dart';

class NavigationController extends StateNotifier<int> {
  final screens = [
    const MessageScreen(),
    const ScheduleScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  NavigationController() : super(0);
  int get index => state;
  void updateState(int index) => state = index;
  // debugPrint(state.toString());
}

final navigationController = StateNotifierProvider<NavigationController, int>(
    (ref) => NavigationController());
