import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/shimmer/chat_card_shimmer.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';

import '../../../../utils/helpers/helper_functions.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
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
                  data: (data) => Padding(
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
                                    color:
                                        isDark ? PColors.dark : PColors.light,
                                    title: 'Dr ${user.fullName}',
                                    subTitle: 'Hello, how can i help you?',
                                    image: PImages.dp2,
                                    recent: false,
                                    onPressed: () => context.go('/chat'));
                              },
                              separatorBuilder: (_, __) => const SizedBox(
                                  height: PSizes.spaceBtwItems / 2),
                            ),
                          ],
                        ),
                      ),
                  error: (error, __) => Center(
                          child: Text(
                        'No Data!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: Colors.white),
                      )),
                  loading: () => const ChatCardShimmer());
            },
          )
        ],
      ),
    );
  }
}
