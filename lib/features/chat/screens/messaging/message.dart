import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/shimmer/chat_card_shimmer.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../common/widgets/cards/ai_chat_card.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/ai_chat_controller.dart';
import '../../controllers/chat_controller.dart';
import '../../models/message_model.dart';

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(chatContactProvider);
    final isDark = PHelperFunctions.isDarkMode(context);
    final responseive = ResponsiveBreakpoints.of(context);
    final user = ref.watch(userProvider);
    final chat = ref.watch(chatContactProvider);
    final messages = ref.watch(aiMessagesProvider);

    debugPrint(ref.read(inChatRoom).toString());

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
          // if (!ref.watch(messagedAi))
          //   Padding(
          //     padding: const EdgeInsets.fromLTRB(PSizes.spaceBtwItems,
          //         PSizes.spaceBtwItems, PSizes.spaceBtwItems, 5),
          //     child: AIChatCard(
          //         color: isDark ? PColors.black : PColors.light,
          //         subTitle: 'Chat with medini, our AI assistant',
          //         onPressed: () =>
          //             ref.read(goRouterProvider).goNamed('aiChat')),
          //   ),
          // if (ref.watch(messagedAi))
          messages.when(
              data: (data) {
                if (data.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(PSizes.spaceBtwItems,
                            PSizes.spaceBtwItems, PSizes.spaceBtwItems, 5),
                        child: AIChatCard(
                            color: isDark ? PColors.black : PColors.light,
                            subTitle: 'Chat with medini, our AI assistant',
                            onPressed: () =>
                                ref.read(goRouterProvider).goNamed('aiChat')),
                      ),
                    ],
                  );
                }
                final message = data.last;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(PSizes.spaceBtwItems,
                          PSizes.spaceBtwItems, PSizes.spaceBtwItems, 5),
                      child: AIChatCard(
                          color: isDark ? PColors.dark : PColors.light,
                          subTitle: message.text,
                          onPressed: () =>
                              ref.read(goRouterProvider).goNamed('aiChat')),
                    ),
                  ],
                );
              },
              error: (error, __) => const SizedBox.shrink(),
              loading: () => const ChatCardShimmer()),
          // const SizedBox(
          //   height: PSizes.spaceBtwItems,
          // ),

          chat.when(
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
                            .apply(color: isDark ? Colors.white : PColors.dark),
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
                  padding: const EdgeInsets.fromLTRB(PSizes.spaceBtwItems, 0,
                      PSizes.spaceBtwItems, PSizes.spaceBtwItems),
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
                              .watch(unrepliedMessagesProvider(
                                  user.id == chat.user2.id
                                      ? chat.user1.id
                                      : chat.user1.id))
                              .value;
                          // updateUnreadMessages(unreadMessages, ref);

                          final count = unreadMessages
                              ?.where((e) {
                                return e.receiverId == (user.id);
                              })
                              .toList()
                              .length;

                          // CHECKS IF THE USDER IS ONLINE
                          final isOnline = ref
                              .watch(checkOnlineStatus(user.id == chat.user2.id
                                  ? chat.user1.id
                                  : chat.user2.id))
                              .value;
                          return ChatCard(
                            isNetworkImage: true,
                            isOnline: isOnline ?? false,
                            unreadMessageCount: count != null && count >= 1
                                ? count.toString()
                                : '',
                            color: isDark ? PColors.dark : PColors.light,
                            title: user.id == chat.user2.id
                                ? chat.user1.isDoctor
                                    ? 'Dr ${chat.user1.lastName}'
                                    : chat.user1.lastName
                                : chat.user2.isDoctor
                                    ? 'Dr ${chat.user2.lastName}'
                                    : chat.user2.lastName,
                            subTitle: chat.lastMessage,
                            image: user.id == chat.user2.id
                                ? chat.user1.profilePicture
                                : chat.user2.profilePicture,
                            recent: false,
                            onCall: false,
                            onPressed: () {
                              ref.read(inChatRoom.notifier).state = true;

                              // ref.watch(chatController).markAsRead(
                              //     unreadMessages!,
                              //     user.id == chat.user2.id
                              //         ? chat.user1.id
                              //         : chat.user2.id);
                              // assign the user to a provider to be used accros the chats
                              ref.read(userChatProvider.notifier).state =
                                  user.id == chat.user2.id
                                      ? chat.user1
                                      : chat.user2;
                              context.goNamed('chat');
                              // ref
                              // .read(loadingCompleteProvider.notifier)
                              // .state = false;
                            },
                            time: PHelperFunctions.getFormattedTime(
                                chat.timeSent),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: PSizes.spaceBtwItems / 2),
                      ),
                    ],
                  ),
                );
              },
              error: (error, __) => Center(
                    child: Text(
                      'No Data! $error',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: isDark ? Colors.white : PColors.dark),
                    ),
                  ),
              loading: () => const ChatCardShimmer())
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

  // updateUnreadMessages(List<MessageModel>? messages, WidgetRef ref) {
  //   //  Update unread messages whenever a new message is received
  //   Future(() {

  //     if (messages != null && messages.isNotEmpty) {
  //       return ref.read(unreadMessageCount.notifier).state = messages.length;
  //     }
  //   });
  // }
}
