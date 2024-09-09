import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:medici/router.dart';

class OnboardingController extends StateNotifier<int> {
  final Ref ref;
  final pageController = PageController();

  OnboardingController(this.ref) : super(0);

  int get index => state;
//  update the indicator state
  void updatePageIndicator(int index) => state = index;

// jujmp to specific dot selected page
  void goToPage(int index) {
    state = index;
    pageController.jumpToPage(
      index,
    );
  }

  // update current index and move to next page
  void nextPage() async {
    final isFirstTime = await Hive.openBox("isFirstTime");
    if (state == 2) {
      await isFirstTime.put('firstTime', false);
      ref.read(goRouterProvider).pushReplacementNamed('login');
    } else {
      state = state + 1;
      pageController.animateToPage(state,
          duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
    }
  }

  // update current index and jump to last page
  void skipPage() {
    state = 2;
    pageController.animateToPage(state,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }
}

final onboardingController = StateNotifierProvider<OnboardingController, int>(
  (ref) => OnboardingController(ref),
);
