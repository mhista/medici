// ignore_for_file: unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:medici/common/widgets/appbar/kAppBar.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../common/widgets/headings/section_heading.dart';
import 'responsive/desktop/desktop_health_update.dart';
import 'widgets/doc_card_list.dart';
import 'widgets/doc_prof_list.dart';
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
              padding: const EdgeInsets.symmetric(
                  vertical: PSizes.spaceBtwItems,
                  horizontal: PSizes.spaceBtwItems),
              child: Column(
                children: [
                  // SCHEDULE COLUMN
                  Column(
                    children: [
                      // SECTION HEADER,

                      SectionHeading(
                        title: 'Upcoming Schedule',
                        showActionButton: true,
                        action: TextButton(
                          onPressed: () {},
                          child: const Text('See all'),
                        ),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 2,
                      ),
                      // SCHEDULE CARD
                      if (responsive.screenWidth < 700) const ScheduleCard(),
                      //
                      if (responsive.screenWidth > 700)
                        const DesktopHealthUpdate()
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),

                  // FINDING A DOCTOR
                  Column(
                    children: [
                      SectionHeading(
                        showActionButton: true,
                        title: 'Let\'s find you a doctor',
                        action: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.filter_list)),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems,
                      ),

                      // FILTERING DOCTORS CHIP LIST
                      const FliterDoctorsList()
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),

                  // LIST OF DOCTORS
                  const DoctorCardList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
