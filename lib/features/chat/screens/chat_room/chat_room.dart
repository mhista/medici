import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
import 'package:medici/features/chat/controllers/chat_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/models/user_model.dart';
import '../../../personalization/controllers/user_controller.dart';
import 'widget/chat_list.dart';

class ChatRoom extends ConsumerWidget {
  const ChatRoom({
    super.key,
    required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatController);
    final isDark = PHelperFunctions.isDarkMode(context);
    final isOnline = ref.watch(checkOnlineStatus(user.id)).value;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: isDark
            ? PColors.dark.withOpacity(0.4)
            : PColors.light.withOpacity(0.4),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_ios_new),
          color: isDark ? PColors.light : PColors.dark,
        ),
        leadingWidth: 25,
        title: Row(
          children: [
            const ProfileImage1(
              image: PImages.dp3,
              imageSize: 40,
              radius: 40,
            ),
            const SizedBox(
              width: PSizes.iconXs,
            ),
            Stack(
              children: [
                TitleAndSubTitle(
                    title: 'Dr ${user.fullName}',
                    subTitle: isOnline ?? false ? 'Online' : 'Offline'),
                Positioned(
                    left: 43,
                    bottom: 4,
                    child: OnlineIndicator(
                      size: 8,
                      isOnline: isOnline ?? false,
                    ))
              ],
            ),
          ],
        ),
        actions: [
          RoundedIcon(
            marginRight: 0,
            padding: 0,
            height: 35,
            width: 35,
            radius: 35,
            isPositioned: false,
            iconData: Icons.video_call,
            hasBgColor: true,
            hasIconColor: true,
            color: PColors.light,
            bgColor: PColors.primary,
            onPressed: () {},
            size: 18,
          ),
          const SizedBox(
            width: PSizes.iconXs,
          ),
          RoundedIcon(
            marginRight: 0,
            padding: 0,
            height: 35,
            width: 35,
            radius: 35,
            size: 18,
            isPositioned: false,
            iconData: Iconsax.call,
            hasBgColor: true,
            hasIconColor: true,
            color: PColors.light,
            bgColor: PColors.primary,
            onPressed: () {},
          ),
          const SizedBox(
            width: PSizes.iconXs,
          ),
        ],
      ),
      body: Column(
        children: [
          // DAILY TIME
          Expanded(child: ChatList(user: user)),
          ChatInputField(controller: controller, user: user),
          EmojiPickerr(controller: controller)
        ],
      ),
    );
  }
}

class ChatInputField extends ConsumerStatefulWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.user,
  });

  final ChatContoller controller;
  final UserModel user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  FocusNode focusNode = FocusNode();

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
                    debugPrint(isShowEmojiContainer.toString());
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
          IconButton(
              onPressed: () => widget.controller
                  .sendMessage(receiver: widget.user, type: MessageType.text),
              icon: const Icon(Iconsax.send_1)),
        ],
      ),
    );
  }
}

// EMOJI SELECTOR
class EmojiPickerr extends ConsumerStatefulWidget {
  const EmojiPickerr({
    super.key,
    required this.controller,
  });
  final ChatContoller controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmojiPickerrState();
}

class _EmojiPickerrState extends ConsumerState<EmojiPickerr> {
  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final emojiColor =
        isDark ? PColors.dark.withOpacity(0.4) : PColors.light.withOpacity(0.4);
    final isShowEmojiContainer =
        ref.watch(widget.controller.showEmojiContainer);
    return isShowEmojiContainer
        ? EmojiPicker(
            config: Config(
                swapCategoryAndBottomBar: true,
                height: 310,
                skinToneConfig:
                    SkinToneConfig(dialogBackgroundColor: emojiColor),
                searchViewConfig: SearchViewConfig(backgroundColor: emojiColor),
                emojiViewConfig:
                    EmojiViewConfig(columns: 8, backgroundColor: emojiColor),
                bottomActionBarConfig: BottomActionBarConfig(
                    enabled: false,
                    backgroundColor: emojiColor,
                    buttonColor: emojiColor),
                categoryViewConfig:
                    CategoryViewConfig(backgroundColor: emojiColor)),
            onEmojiSelected: ((category, emoji) {
              setState(() {
                widget.controller.text.text =
                    widget.controller.text.text + emoji.emoji;
              });
            }))
        : const SizedBox();
  }
}
