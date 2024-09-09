import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/common/styles/spacing_styles.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/features/specialists/controllers/specialist_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../common/widgets/appbar/searchBar.dart';
import '../../../../common/widgets/cards/chat_card.dart';
import '../../../../common/widgets/shimmer/chat_card_shimmer.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class AllDoctors extends StatelessWidget {
  const AllDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final responseive = ResponsiveBreakpoints.of(context);
    return Scaffold(
      body: Padding(
        padding: PSpacingStyle.mapPadding,
        child: ListView(
          children: [
            // SEARCH BAR
            MSearchBar(
              hintText: PTexts.chatSearchText,
              useSuffix: true,
              useBorder: false,
              color: PColors.primary.withOpacity(0.5),
              hasColor: true,
            ),
            const SizedBox(
              height: PSizes.spaceBtwItems,
            ),
            Consumer(
              builder: (_, WidgetRef ref, __) {
                return ref.watch(fetchAllDoctorsProvider).when(
                    data: (data) {
                      if (data.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // const SizedBox(
                            //   height: PSizes.spaceBtwSections * 2,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                'No Doctors available at the moment, check back later',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(
                                        color: isDark
                                            ? Colors.white
                                            : PColors.dark),
                              ),
                            ),
                            const SizedBox(
                              height: PSizes.spaceBtwSections,
                            ),
                            SizedBox(
                              width: responseive.screenWidth / 2,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View Available Doctors',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .apply(color: Colors.white),
                                  )),
                            )
                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final doctor = data[index];
                                return ChatCard(
                                    isNetworkImage: true,
                                    color:
                                        isDark ? PColors.dark : PColors.light,
                                    title: doctor.name,
                                    subTitle: doctor.specialty,
                                    image: doctor.profileImage,
                                    recent: false,
                                    onPressed: () async {
                                      debugPrint(doctor.id);
                                      await ref
                                          .read(userController)
                                          .fetchAUserRecord(doctor.id)
                                          .then((onValue) {
                                        ref.read(goRouterProvider).goNamed(
                                            'chat',
                                            extra: ref.read(
                                                specialistUserModelProvider));
                                      });
                                    });
                              },
                              separatorBuilder: (_, __) => const SizedBox(
                                  height: PSizes.spaceBtwItems / 2),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (error, __) => Center(
                          child: Text(
                            'No Data!',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: Colors.white),
                          ),
                        ),
                    loading: () => const ChatCardShimmer());
              },
            )
          ],
        ),
      ),
    );
  }
}
