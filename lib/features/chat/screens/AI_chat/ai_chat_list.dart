import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/features/chat/controllers/ai_chat_controller.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/features/chat/screens/AI_chat/widgets/ai_chat_text.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/utils/constants/colors.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../common/widgets/button/scroll_button.dart';
import '../../../../common/widgets/icons/circular_icon.dart';

class AIChatList extends ConsumerStatefulWidget {
  const AIChatList({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AIChatListState();
}

class _AIChatListState extends ConsumerState<AIChatList> {
  final ScrollController _messageController = ScrollController();
  void onMessageSwipe(String message, bool isMe, String messageEnum) {
    ref.read(messageReplyProvider.notifier).update((state) =>
        MessageReply(message: message, isMe: isMe, messageEnum: messageEnum));
  }

  void _scrollToBottom() {
    // Use SchedulerBinding to schedule the scrolling action
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _messageController.animateTo(
        _messageController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = PHelperFunctions.screenWidth(context);
    final messages = ref.watch(aiMessagesProvider);

    return Stack(
      children: [
        ListView(shrinkWrap: true, controller: _messageController, children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(PSizes.iconXs),
              child: TimeCard(
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(
            height: PSizes.spaceBtwItems,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: PSizes.spaceBtwItems,
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       ChatTextContainer(
          //           width: screenWidth / 1.7,
          //           isUser: false,
          //           isDark: isDark,
          //           text:
          //               'Hello! My name is Medini, your friendly healthcare assistant. How can I assist you today? 😊'),
          //     ],
          //   ),
          // ),
          messages.when(
              data: (data) {
                // CONTROLLER TO CONTROL THE CHAT SCROLL
                _scrollToBottom();

                // SchedulerBinding.instance.addPostFrameCallback((_) {
                //   _messageController.animateTo(
                //       _messageController.position.maxScrollExtent,
                //       duration: const Duration(milliseconds: 500),
                //       curve: Curves.linear);
                //   // ref.read(loadingCompleteProvider.notifier).state = true;
                //   // debugPrint(ref.read(loadingCompleteProvider).toString());
                // });
                // SchedulerBinding.instance.
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final message = data[index];
                    return AIChatText(
                        text: message.text,
                        time:
                            PHelperFunctions.getFormattedTime(message.timeSent),
                        isUser: message.isUser,
                        width: message.text.length < 10
                            ? screenWidth / 3
                            : message.text.length < 30
                                ? screenWidth / 1.7
                                : screenWidth / 1.5);
                  },
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
              loading: () => const Column(
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: PColors.primary,
                        ),
                      ),
                    ],
                  ))
        ]),
        ScrollToBottomButton(
          onPressed: _scrollToBottom,
          controller: _messageController,
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }
}



// List<Column> get chatShimmerList {
//   return [
//     const Column(
//         mainAxisAlignment: MainAxisAlignment.start,

//         children: [
//           PShimmerEffect(height: 60, width: 150),
//           SizedBox(
//             height: PSizes.sm,
//           ),
//         ]),
//     const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       PShimmerEffect(height: 40, width: 100),
//       SizedBox(
//         height: PSizes.sm,
//       ),
//     ]),
//     const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//       PShimmerEffect(height: 70, width: 100),
//       SizedBox(
//         height: PSizes.sm,
//       ),
//     ]),
//     const Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
//       PShimmerEffect(height: 50, width: 100),
//       SizedBox(
//         height: PSizes.sm,
//       ),
//     ]),
//     const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       PShimmerEffect(height: 20, width: 100),
//       SizedBox(
//         height: PSizes.sm,
//       ),
//     ]),
//     const Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [PShimmerEffect(height: 30, width: 100)])
//   ];
// }
