import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/searchBar.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../authentication/models/user_model.dart';
import '../../../controllers/chat_controller.dart';
import 'chat_recorder.dart';

class ChatInputField extends ConsumerStatefulWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.user,
  });

  final ChatController controller;
  final UserModel user;

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
      padding: const EdgeInsets.only(bottom: 10.0, right: 5),
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
                      builder: (_, WidgetRef ref, __) => isShowEmojiContainer
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
                hintText: 'Type Something...',
                textFieldWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => widget.controller.sendMessageFile(
                              receiver: widget.user,
                            ),
                        icon: const Icon(Icons.camera_alt)),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.attach_file)),
                  ],
                ),
              ),
            ),
          ),
          ref.watch(widget.controller.textProvider)
              ? IconButton(
                  onPressed: () => widget.controller.sendMessage(
                      receiver: widget.user, type: MessageType.text),
                  icon: const Icon(Iconsax.send_1))
              : RecorderButton(
                  user: widget.user,
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
