import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:medici/utils/device/device_utility.dart';
import 'package:medici/utils/helpers/helper_functions.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../containers/rounded_icon_container.dart';
import '../icons/rounded_icons.dart';
import 'searchBar.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({super.key});

  // to add the background color to tabs, wrap with material widget.

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);

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
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        PTexts.homeAppBarTitle,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 2,
                      ),
                      Text(
                        PTexts.homeAppBarSubTitle,
                        style: Theme.of(context).textTheme.labelMedium,
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

                      RoundedIcon(
                        isPositioned: true,
                        iconData: Iconsax.notification,
                        onPressed: () {},
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
              if (responsive.screenWidth < 700)
                RoundedIcon(
                  height: 50,
                  width: 50,
                  radius: 50,
                  isPositioned: true,
                  iconData: Iconsax.notification,
                  onPressed: () {},
                )
            ],
          ),
        ),
        if (responsive.screenWidth < 700)
          const MSearchBar(hintText: PTexts.hintText),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight() * 2);
}

// // SEARCHBAR IF SCREEN WIDTH IS LESS DOWN 700
//               