import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/onboarding/onboarding_controller.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/onboarding_skip.dart';
import 'widgets/onboardingnavigationdot.dart';
import 'widgets/onboardingnext.dart';

class OnBoardingScreen extends ConsumerWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(onboardingController.notifier);
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: PImages.onboarding,
                subtitle: PTexts.onBoardingSubTitle1,
                title: PTexts.onBoardingTitle1,
              ),
              OnBoardingPage(
                image: PImages.onboarding1,
                subtitle: PTexts.onBoardingSubTitle2,
                title: PTexts.onBoardingTitle2,
              ),
              OnBoardingPage(
                image: PImages.onboarding2,
                subtitle: PTexts.onBoardingSubTitle3,
                title: PTexts.onBoardingTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          // Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
