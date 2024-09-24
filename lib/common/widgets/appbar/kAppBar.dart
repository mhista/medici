import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:medici/utils/device/device_utility.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../router.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../icons/rounded_icons.dart';
import 'searchBar.dart';

class KAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const KAppBar({super.key});

  // to add the background color to tabs, wrap with material widget.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isDark = PHelperFunctions.isDarkMode(context);
    final data = ref.watch(callModelProvider);

    return Column(
      children: [
        Padding(
          padding: responsive.orientation == Orientation.landscape
              ? const EdgeInsets.only(top: 8.0)
              : const EdgeInsets.only(top: 0),
          child: AppBar(
            // titleSpacing: 100,
            // leadingWidth: double.maxFinite,

            // NOTIFICATION ICON, SEARCHBAR IF IN DESKTOP MODE
            title: Row(children: [
              if (responsive.screenWidth < 700)
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer(
                        builder: (_, WidgetRef ref, __) {
                          final user = ref.watch(userProvider);

                          return Text(
                            'Hi, ${user.fullName}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          );
                        },
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 2,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location5,
                            color: PColors.primary,
                          ),
                          const SizedBox(
                            width: PSizes.xs,
                          ),
                          Text(
                            "New York, USA",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              if (responsive.screenWidth > 700)
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SEARCH BAR
                      const Expanded(
                        child: MSearchBar(
                          hintText: PTexts.hintText,
                        ),
                      ),
                      // NOTIFICATION BUTTON

                      Consumer(
                        builder: (_, WidgetRef ref, __) {
                          return RoundedIcon(
                            isPositioned: true,
                            iconData: Iconsax.notification,
                            onPressed: () => ref
                                .read(specialistController)
                                .uploadSpecialistDummy(),
                          );
                        },
                      )
                    ],
                  ),
                ),

              // SHOWS A CICLE AVATER IMAGE IF IN DESKTOP MODE
              if (responsive.isDesktop || responsive.screenWidth > 900)
                const Padding(
                  padding: EdgeInsets.only(right: PSizes.iconXs),
                  child: CircleAvatar(
                    backgroundColor: PColors.accent,
                    // backgroundImage: Image(image: AssetImage(FlutterLogo().toString())),
                  ),
                )
            ]),

            actions: [
              // SHOW ONLY A NOTIFICATION ICON ON SMALL SCREEN
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return ref.watch(isCallOngoing)
                      ? PCircularIcon(
                          backgroundColor: Colors.green,
                          height: 40,
                          width: 40,
                          icon: Iconsax.call,
                          color: Colors.white,
                          onPressed: () async {
                            debugPrint(data.toString());
                            // ref.read(callController).pickModelCall(data);
                            ref.read(switchToButton.notifier).state = false;
                            ref.read(callScreenPopped.notifier).state = false;
                            ref.read(goRouterProvider).goNamed('chatHolder');
                          },
                        )
                      : const SizedBox();
                },
              ),
              if (responsive.screenWidth < 700)
                PCircularIcon(
                  backgroundColor: isDark
                      ? PColors.dark.withOpacity(0.9)
                      : PColors.white.withOpacity(0.9),
                  height: 50,
                  width: 50,
                  icon: Iconsax.profile_circle,
                  onPressed: () {},
                ),
              Consumer(
                builder: (_, WidgetRef ref, __) {
                  return PCircularIcon(
                    backgroundColor: isDark
                        ? PColors.dark.withOpacity(0.9)
                        : PColors.white.withOpacity(0.9),
                    height: 50,
                    width: 50,
                    icon: Iconsax.notification,
                    onPressed: () => ref.read(userController).signOut(),
                  );
                },
              )
            ],
          ),
        ),
        // if (responsive.screenWidth < 700)
        // const MSearchBar(hintText: PTexts.hintText),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}

// // SEARCHBAR IF SCREEN WIDTH IS LESS DOWN 700
//               