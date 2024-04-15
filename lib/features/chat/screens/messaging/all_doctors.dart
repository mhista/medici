import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/providers.dart';
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
      body: ListView(
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
              return ref.watch(fetchAllUsersProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: PSizes.spaceBtwSections * 2,
                          ),
                          Text(
                            'No Doctors available at the moment, checek back later',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(
                                    color:
                                        isDark ? Colors.white : PColors.dark),
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
                      padding: const EdgeInsets.all(PSizes.spaceBtwItems),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final user = data[index];
                              return ChatCard(
                                  isNetworkImage: true,
                                  color: isDark ? PColors.dark : PColors.light,
                                  title: 'Dr ${user.fullName}',
                                  subTitle: 'Heart Surgeon',
                                  image: user.profilePicture,
                                  recent: false,
                                  onPressed: () =>
                                      context.goNamed('chat', extra: user));
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
    );
  }
}
