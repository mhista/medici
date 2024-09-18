import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/loaders/loaders.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../authentication/models/user_model.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../controllers/chat_controller.dart';
import 'chat_text.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
    required this.receiver,
  });

  final UserModel receiver;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  void onMessageSwipe(String message, bool isMe, String messageEnum) {
    ref.read(messageReplyProvider.notifier).update((state) =>
        MessageReply(message: message, isMe: isMe, messageEnum: messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = PHelperFunctions.screenWidth(context);
    final messages = ref.watch(chatMessagesProvider(widget.receiver.id));

    return ListView(shrinkWrap: true, controller: messageController, children: [
      const Center(
        child: Padding(
          padding: EdgeInsets.all(PSizes.iconXs),
          child: TimeCard(
            elevation: 0,
          ),
        ),
      ),
      messages.when(
          data: (data) {
            // CONTROLLER TO CONTROL THE CHAT SCROLL
            SchedulerBinding.instance.addPostFrameCallback((_) {
              messageController.animateTo(
                  messageController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
              // ref.read(loadingCompleteProvider.notifier).state = true;
              // debugPrint(ref.read(loadingCompleteProvider).toString());
            });
            // SchedulerBinding.instance.
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final message = data[index];
                return GestureDetector(
                  onTap: () {
                    debugPrint('delete ');
                    PLoaders.customToast(
                        context: context,
                        message: 'swipe left to reply, or right to delete');
                  },
                  child: ChatText(
                    messageType: message.type,
                    text: message.text,
                    time: PHelperFunctions.getFormattedTime(message.timeSent),
                    // checks if the current user is the same as the message recepient
                    // TODO : message.senderId == ref.watch(userProvider).id ? true :false
                    isUser:
                        message.receiverId == widget.receiver.id ? true : false,
                    width: message.type == MessageType.text.name
                        ? message.text.length < 10
                            ? screenWidth / 3
                            : message.text.length < 30
                                ? screenWidth / 1.7
                                : screenWidth / 1.5
                        : message.type == MessageType.text.name
                            ? screenWidth / 4
                            : 0,
                    repliedText: message.repliedMessage,
                    repliedMessageType: message.repliedMessageType,
                    // DELETE A MESSAGE ON RIGHT SWIPE
                    onRightSwipe: () async {
                      // checks if this message was swiped for reply and deletes it
                      if (ref.watch(messageReplyProvider)?.message ==
                          message.text) {
                        ref.read(messageReplyProvider.notifier).state = null;
                      }
                      // ref.read(chatController).deleteMessage(message: message);
                      // checks if this message is the one shown in the list of messages in the chat view
                      final isLastChat = ref
                          .watch(chatContactProvider)
                          .value
                          ?.where((chat) => chat.messageId == message.messageId)
                          .firstOrNull;
                      // if it is the last message, deletes the message from the user chats, and updates the currently shown chat message with the last message sent
                      if (isLastChat != null) {
                        debugPrint(isLastChat.toString());
                        // deletes the message
                        await ref
                            .read(chatController)
                            .deleteMessage(message: message);

                        // gets the last message sent by the user to update the chat view with the last message
                        final lastMessage = ref
                            .watch(chatMessagesProvider(widget.receiver.id))
                            .value
                            ?.reversed
                            .elementAtOrNull(0);
                        // if there is a new last message, updates  the chat view with the last message
                        if (lastMessage != null) {
                          debugPrint(lastMessage.toString());

                          await ref.read(chatController).saveChatContacts(
                              timeSent: lastMessage.timeSent,
                              receiver: lastMessage.receiverId ==
                                      ref.read(userProvider).id
                                  ? ref.read(userProvider)
                                  : ref.read(userChatProvider),
                              sender: lastMessage.senderId ==
                                      ref.read(userProvider).id
                                  ? ref.read(userProvider)
                                  : ref.read(userChatProvider),
                              message: lastMessage);
                        } else {
                          // if there is no current message, proceeds to delete the chat contact
                          ref
                              .read(chatController)
                              .deleteMessage(message: message);
                          ref.read(chatController).deleteChatContact(
                              receiverId: widget.receiver.id,
                              senderId: ref.read(userProvider).id);
                          // ref
                          //     .read(chatController)
                          //     .deleteMessage(message: message);
                        }
                      } else {
                        ref
                            .read(chatController)
                            .deleteMessage(message: message);
                      }
                    },
                    onLeftSwipe: () => onMessageSwipe(
                        message.text,
                        message.receiverId == widget.receiver.id ? true : false,
                        message.type),
                    username: message.repliedTo,
                  ),
                );
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
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
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
