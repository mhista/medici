import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/features/chat/models/message_reply.dart';

import '../../../../../common/widgets/appbar/searchBar.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../authentication/models/user_model.dart';
import '../../../controllers/chat_controller.dart';
import 'chat_recorder.dart';

class ChatInputField extends ConsumerStatefulWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.messageReply,
    required this.receiver,
  });

  final ChatController controller;
  final UserModel receiver;
  final MessageReply? messageReply;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isShowEmojiContainer =
        ref.watch(widget.controller.showEmojiContainer);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 5, top: 5),
      child: Row(
        children: [
          Flexible(
            child: Form(
              key: widget.controller.chatFormKey,
              child: MSearchBar(
                onChanged: widget.controller.checkEmptyText(),
                focusNode: focusNode,
                textController: widget.controller.text,
                usePrefixSuffix: true,
                prefixWidget: IconButton(
                  icon: Consumer(
                      builder: (_, WidgetRef ref, __) => !isShowEmojiContainer
                          ? const Icon(Icons.emoji_emotions_outlined)
                          : const Icon(Icons.keyboard_alt_outlined)),
                  onPressed: () {
                    if (!isShowEmojiContainer) {
                      setState(() {
                        focusNode.unfocus();

                        ref
                            .read(widget.controller.showEmojiContainer.notifier)
                            .update((state) => state = true);
                      });
                    } else {
                      setState(() {
                        ref
                            .read(widget.controller.showEmojiContainer.notifier)
                            .update((state) => state = false);
                        FocusScope.of(context).requestFocus(focusNode);
                        // focusNode.requestFocus();
                      });
                    }
                  },
                ),
                onTap: (() {
                  if (isShowEmojiContainer) {
                    setState(() {
                      ref
                          .read(widget.controller.showEmojiContainer.notifier)
                          .update((state) => state = false);

                      FocusScope.of(context).requestFocus(focusNode);
                      // focusNode.requestFocus();
                    });
                  }
                }),
                hintText: ref.watch(isRecordingProvider)
                    ? 'recording....'
                    : 'Type Something...',
                textFieldWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          widget.controller.sendMessageFile(
                            receiver: widget.receiver,
                            messageReply: widget.messageReply,
                          );
                          ref
                              .read(messageReplyProvider.notifier)
                              .update((state) => null);
                        },
                        icon: const Icon(Icons.camera_alt)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.attach_file)),
                  ],
                ),
              ),
            ),
          ),
          ref.watch(textProvider)
              ? IconButton(
                  onPressed: () {
                    widget.controller.sendTextMessage(
                        receiver: widget.receiver,
                        type: MessageType.text,
                        messageReply: widget.messageReply);
                    ref
                        .read(messageReplyProvider.notifier)
                        .update((state) => null);
                    // focusNode.unfocus();
                  },
                  icon: const Icon(Iconsax.send_1))
              : RecorderButton(
                  receiver: widget.receiver,
                )
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.text.removeListener(() {});

    super.dispose();
  }
}
