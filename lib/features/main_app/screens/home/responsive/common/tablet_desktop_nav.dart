import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../controller/navigation_controller.dart';

// DRAWER THAT ALIGNS ITSELF DIFFERENTLY ON TABLETS

class TabletDesktopNavigation extends ConsumerWidget {
  const TabletDesktopNavigation({
    super.key,
    required this.controller,
  });

  final NavigationController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ResponsiveBreakpoints.of(context);

    return SizedBox(
      width: responsive.smallerThan(TABLET) ? 50 : 200,
      child: NavigationDrawer(
        // indicatorShape: null,
        indicatorColor: PColors.transparent,
        onDestinationSelected: (index) => controller.updateState(index),
        selectedIndex: controller.index,
        children: const [
          DrawerHeader(
              margin: EdgeInsets.symmetric(
                  vertical: PSizes.spaceBtwSections,
                  horizontal: PSizes.spaceBtwInputFields),
              padding: EdgeInsets.all(PSizes.lg),
              child: FlutterLogo(
                size: 5,
              )),
          SizedBox(
            height: PSizes.spaceBtwSections * 2,
          ),
          NavigationDrawerDestination(
              backgroundColor: PColors.transparent,
              icon: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Center(child: Icon(Iconsax.home)),
              ),
              label: Text('')),
          SizedBox(
            height: PSizes.spaceBtwItems,
          ),
          NavigationDrawerDestination(
              icon: Icon(Iconsax.calendar), label: Text('Schedule')),
          SizedBox(
            height: PSizes.spaceBtwItems,
          ),
          NavigationDrawerDestination(
              icon: Icon(Iconsax.message), label: Text('Chat')),
          SizedBox(
            height: PSizes.spaceBtwItems,
          ),
          NavigationDrawerDestination(
              icon: Icon(Iconsax.user), label: Text('Profile')),
        ],
      ),
    );
  }
}
