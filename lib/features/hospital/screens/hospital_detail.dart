import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/tabbar.dart';
import 'package:medici/common/widgets/badge/reviewBadge.dart';
import 'package:medici/common/widgets/chips/filter_chip.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/icons/positioned_icon.dart';
import 'package:medici/features/hospital/screens/widgets/about/about.dart';
import 'package:medici/features/hospital/screens/widgets/gallary/gallary.dart';
import 'package:medici/features/hospital/screens/widgets/hospital_card_details.dart';
import 'package:medici/features/hospital/screens/widgets/reviews/reviews.dart';
import 'package:medici/features/hospital/screens/widgets/specialists/specialists.dart';
import 'package:medici/features/hospital/screens/widgets/treatments/treatments.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

import '../../../common/widgets/button/bottom_button.dart';
import '../../../common/widgets/curved_edges/curved_edges_widget.dart';
import '../../../common/widgets/images/edge_rounded_images.dart';
import '../../../router.dart';
import '../../../utils/constants/image_strings.dart';

class HospitalDetail extends ConsumerWidget {
  const HospitalDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: 470,
                collapsedHeight: 217,
                floating: true,
                flexibleSpace: TRoundedContainer(
                  height: PHelperFunctions.screenHeight(context),
                  // width: PHelperFunctions.screenWidth(context),
                  radius: 0,
                  child: Stack(
                    children: [
                      // Hospital picture
                      MCurvedEdgesWidget(
                        child: TRoundedContainer(
                          height: 250,
                          backgroundColor: PColors.light.withOpacity(0.5),
                          child: Stack(
                            children: [
                              MRoundedImage(
                                borderRadius: 0,
                                height: 300,
                                width: PHelperFunctions.screenWidth(context),
                                imageUrl: PImages.hospital2,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 50,
                                child: SizedBox(
                                  width: PHelperFunctions.screenWidth(context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        StackIcon(
                                          icon: Icons.arrow_back,
                                          onPressed: () =>
                                              ref.read(goRouterProvider).pop(),
                                          top: 10,
                                          left: -10,
                                        ),
                                        // const Spacer(),
                                        Row(
                                          children: [
                                            StackIcon(
                                              icon: Icons.share,
                                              onPressed: () {},
                                              top: 10,
                                              right: -15,
                                            ),
                                            const SizedBox(
                                              width: PSizes.spaceBtwItems / 2,
                                            ),
                                            StackIcon(
                                              icon: Iconsax.heart,
                                              onPressed: () {},
                                              top: 10,
                                              right: -10,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      // Hospital details and other informations
                      Positioned(
                        top: 250,
                        right: 0,
                        left: 0,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: PSizes.spaceBtwItems / 2,
                                horizontal: PSizes.spaceBtwItems),
                            child: Column(
                              children: [
                                const HospitalCardDetails(
                                  increaseBy: 3,
                                ),
                                const SizedBox(
                                  height: PSizes.spaceBtwItems,
                                ),
                                // contact buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    HospitalDetailButton(
                                        iconData: Iconsax.global5,
                                        onPressed: () {},
                                        text: 'Website'),
                                    HospitalDetailButton(
                                        iconData: Iconsax.message5,
                                        onPressed: () {},
                                        text: 'Message'),
                                    HospitalDetailButton(
                                        iconData: Iconsax.call5,
                                        onPressed: () {},
                                        text: 'Call'),
                                    HospitalDetailButton(
                                        iconData: Iconsax.map_15,
                                        onPressed: () {},
                                        text: 'Direction'),
                                    HospitalDetailButton(
                                        iconData: Iconsax.send_21,
                                        onPressed: () {},
                                        text: 'Share'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 215,
                        right: 110,
                        left: 110,
                        child: ReviewBadge(
                          reviewWidth: 130,
                          isFullWidth: true,
                          color: PColors.primary,
                          textColor: PColors.light,
                          iconColor: PColors.light,
                        ),
                      )
                    ],
                  ),
                ),
                bottom: const MTabBar(
                  tabs: [
                    Text(
                      "Treatment",
                    ),
                    Text(
                      "Specialist",
                    ),
                    Text(
                      "Gallary",
                    ),
                    Text(
                      "Review",
                    ),
                    Text(
                      "About",
                    ),
                  ],
                ),
              )
            ];
          },
          body: const TabBarView(children: [
            // Treatment Tab
            Treatments(),
            // Specialist Tab
            Specialists(),
            // Gallary Tab
            GallaryView(),
            // Reviewer Tab
            Reviews(),
            // About
            AboutDetail()
          ]),
        ),
        bottomNavigationBar: BottomButton(
          text: 'Book Appointment',
          onTap: () {},
        ),
      ),
    );
  }
}

// HOSPITAL DETAILS BUTTON
class HospitalDetailButton extends StatelessWidget {
  const HospitalDetailButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.text,
  });
  final IconData iconData;
  final Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ButtonChip(
      iconData: iconData,
      text: text,
      onSelected: onPressed,
      textSize: 2,
      textWeight: 2,
      spaceBtwBtn: -4,
    );
  }
}
