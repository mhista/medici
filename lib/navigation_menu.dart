// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';

// import 'utils/constants/colors.dart';
// import 'utils/helpers/helper_functions.dart';

// class NavigationMenu extends StatelessWidget {
//   const NavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDark = PHelperFunctions.isDarkMode(context);
//     // final controller = Get.put(NavigationController());
//     return Scaffold(
//       bottomNavigationBar: Obx(
//         () => NavigationBar(
//             backgroundColor: isDark ? PColors.black : PColors.white,
//             indicatorColor: isDark
//                 ? PColors.white.withOpacity(0.1)
//                 : PColors.black.withOpacity(0.1),
//             height: 80,
//             elevation: 0,
//             selectedIndex: controller.selectedIndex.value,
//             onDestinationSelected: (index) =>
//                 controller.selectedIndex.value = index,
//             destinations: const [
//               NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
//               NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
//               NavigationDestination(
//                   icon: Icon(Iconsax.heart), label: 'Wishlist'),
//               NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
//             ]),
//       ),
//       body: Obx(() => controller.screens[controller.selectedIndex.value]),
//     );
//   }
// }

// class NavigationController extends StateNotifier<int> {
//   final Rx<int> selectedIndex = 0.obs;

//   final screens = [
//     const HomeScreen(),
//     const Store(),
//     const WishListScreen(),
//     const SettingsScreen()
//   ];

//   NavigationController(super.state);
// }
