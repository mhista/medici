import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/shimmer/chat_card_shimmer.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/chat_controller.dart';
import '../chat_room/chat_room.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final responseive = ResponsiveBreakpoints.of(context);

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
              // user1 =  current user
              // user2 = the receiver
              // FETCH THE LAST CHAT OF THE USER AND DISPLAY ON THE MESSAGE SCREEN
              return ref.watch(chatContactProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            height: PSizes.spaceBtwSections * 2,
                          ),
                          // IF DATA IS EMPTY, DISPLAY EMPTY MESSAGE
                          Text(
                            'No Messages',
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
                          if (!ref.read(userProvider).isDoctor)
                            SizedBox(
                              width: responseive.screenWidth / 2,
                              child: ElevatedButton(
                                  onPressed: () => context.goNamed('doctors'),
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
                    // DISPLAY THE LIST OF USER MESSAGES
                    return Padding(
                      padding: const EdgeInsets.all(PSizes.spaceBtwItems),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final chat = data[index];
                              // RETURNS THE COUNT OF UNREPLIED MESSAGES AND DISPLAYS IT ON THE CHAT CARD
                              final unreadMessages = ref
                                  .watch(
                                      unrepliedMessagesProvider(chat.user2.id))
                                  .value
                                  ?.where((e) {
                                return e.receiverId == chat.user1.id;
                              }).toList();
                              final count = unreadMessages?.length;

                              // CHECKS IF THE USDER IS ONLINE
                              final isOnline = ref
                                  .watch(checkOnlineStatus(chat.user2.id))
                                  .value;
                              return ChatCard(
                                isOnline: isOnline ?? false,
                                unreadMessageCount: count != null && count >= 1
                                    ? count.toString()
                                    : '',
                                color: isDark ? PColors.dark : PColors.light,
                                title: chat.user2.isDoctor
                                    ? 'Dr ${chat.user2.fullName}'
                                    : chat.user2.fullName,
                                subTitle: chat.lastMessage,
                                image: PImages.dp2,
                                recent: false,
                                onPressed: () {
                                  ref.watch(chatController).markAsRead(
                                      unreadMessages!, chat.user2.id);
                                  // assign the user to a provider to be used accros the chats
                                  ref.read(userChatProvider.notifier).state =
                                      chat.user2;
                                  context.goNamed('chatHolder');
                                  // ref
                                  // .read(loadingCompleteProvider.notifier)
                                  // .state = false;
                                },
                                time: PHelperFunctions.getFormattedTime(
                                    chat.timeSent),
                              );
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
                          'No Data! $error',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                              color: isDark ? Colors.white : PColors.dark),
                        ),
                      ),
                  loading: () => const ChatCardShimmer());
            },
          )
        ],
      ),
      floatingActionButton: ref.read(userProvider).isDoctor
          ? null
          : FloatingActionButton(
              onPressed: () => context.goNamed('doctors'),
              backgroundColor: PColors.primary,
              child: const Icon(Iconsax.add),
            ),
    );
  }
}
