// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/kAppBar.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/icons/circular_icon.dart';
import 'package:medici/common/widgets/images/circular_images.dart';
import 'package:medici/common/widgets/images/edge_rounded_images.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../common/widgets/headings/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../hospital/screens/widgets/services.dart';
import 'responsive/desktop/desktop_health_update.dart';
import 'widgets/doc_card_list.dart';
import 'widgets/doc_prof_list.dart';
import '../../../hospital/screens/widgets/hospital_card.dart';
import 'widgets/schedule_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final isDark = PHelperFunctions.isDarkMode(context);
    final responsive = ResponsiveBreakpoints.of(context);

    return Scaffold(
      appBar: const KAppBar(),
      body: SafeArea(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: PSizes.spaceBtwItems / 1.5),
              child: Column(
                children: [
                  // SCHEDULE COLUMN
                  Column(
                    children: [
                      const SizedBox(
                        height: PSizes.spaceBtwItems,
                      ),
                      // SECTION HEADER,
                      // const SectionHeading(
                      //   title: 'Services for your health',
                      // ),
                      // const SizedBox(
                      //   height: PSizes.spaceBtwItems,
                      // ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ServicesWidget(
                              imageUrl: PImages.stethoscope,
                              text: "Specialists"),
                          ServicesWidget(
                              imageUrl: PImages.pill, text: "Pharmacy"),
                          ServicesWidget(
                              imageUrl: PImages.clinic, text: "Clinics"),
                          ServicesWidget(
                              imageUrl: PImages.ambulance, text: "Ambulance"),
                        ],
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems,
                      ),
                      const SectionHeading(
                        title: 'Upcoming Schedule',
                        buttonTitle: 'See All',
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 2,
                      ),
                      // SCHEDULE CARD
                      if (responsive.screenWidth < 700)
                        const Padding(
                          padding: EdgeInsets.only(right: PSizes.spaceBtwItems),
                          child: ScheduleCard(),
                          // child: TRoundedContainer(
                          //   backgroundColor: PColors.light,
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       Flexible(
                          //         child: Column(
                          //           children: [
                          //             const Text(
                          //                 "A Strong defense for your family's health"),
                          //             ElevatedButton(
                          //                 onPressed: () {},
                          //                 child: const Text("Read more"))
                          //           ],
                          //         ),
                          //       ),
                          //       const MRoundedImage(imageUrl: PImages.dp2)
                          //     ],
                          //   ),
                          // ),
                        ),
                      //
                      if (responsive.screenWidth > 700)
                        const DesktopHealthUpdate()
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),

                  // FINDING A DOCTOR
                  const Column(
                    children: [
                      SectionHeading(
                        buttonTitle: 'See All',
                        title: 'Top Specialists',
                      ),
                      SizedBox(
                        height: PSizes.spaceBtwItems / 2,
                      ),

                      // FILTERING DOCTORS CHIP LIST
                      FliterDoctorsList()
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),

                  // LIST OF DOCTORS
                  const SectionHeading(
                    buttonTitle: 'See All',
                    title: 'Nearby Hospitals',
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems / 2,
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: PSizes.spaceBtwItems / 3),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const HospitalCard(
                          isFullWidth: false,
                          width: 250,
                          reviewWidth: 60,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems * 2,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
