import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/main_app/screens/map/map.dart';

import '../../personalization/screens/profile.dart';
import '../screens/home/home.dart';
import '../screens/messaging/message.dart';
import '../screens/schedules/schedule.dart';

class NavigationController extends StateNotifier<int> {
  final screens = [
    const MapScreen(),
    const MessageScreen(),
    const HomeScreen(),
    const ScheduleScreen(),
  ];

  NavigationController() : super(0);
  int get index => state;
  void updateState(int index) => state = index;
  // debugPrint(state.toString());
}

final navigationController = StateNotifierProvider<NavigationController, int>(
    (ref) => NavigationController());
