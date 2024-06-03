import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/enums.dart';

import '../../../../../common/widgets/cards/time_card.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../authentication/models/user_model.dart';
import '../../../controllers/chat_controller.dart';
import 'chat_text.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
    required this.user,
  });

  final UserModel user;

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
    final messages = ref.watch(chatMessagesProvider(widget.user.id));

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
            });
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final message = data[index];
                return GestureDetector(
                  onLongPress: () {
                    debugPrint('delete ');
                  },
                  child: ChatText(
                    messageType: message.type,
                    text: message.text,
                    time: PHelperFunctions.getFormattedTime(message.timeSent),
                    isUser: message.receiverId == widget.user.id ? true : false,
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
                    onLeftSwipe: () => onMessageSwipe(
                        message.text,
                        message.receiverId == widget.user.id ? true : false,
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
          loading: () => const Center(
                child: CircularProgressIndicator(
                  color: PColors.primary,
                ),
              ))
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
}
