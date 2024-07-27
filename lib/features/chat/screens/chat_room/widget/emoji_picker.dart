// EMOJI SELECTOR
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/chat_controller.dart';

class EmojiPickerr extends ConsumerStatefulWidget {
  const EmojiPickerr({
    super.key,
    required this.controller,
  });
  final ChatController controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmojiPickerrState();
}

class _EmojiPickerrState extends ConsumerState<EmojiPickerr> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final emojiColor =
        isDark ? PColors.dark.withOpacity(0.4) : PColors.light.withOpacity(0.4);
    final isShowEmojiContainer =
        ref.watch(widget.controller.showEmojiContainer);
    return isShowEmojiContainer
        ? const SizedBox(
            height: 310,
          )
        // EmojiPicker(
        //     config: Config(
        //         swapCategoryAndBottomBar: true,
        //         height: 310,
        //         skinToneConfig:
        //             SkinToneConfig(dialogBackgroundColor: emojiColor),
        //         searchViewConfig: SearchViewConfig(backgroundColor: emojiColor),
        //         emojiViewConfig:
        //             EmojiViewConfig(columns: 8, backgroundColor: emojiColor),
        //         bottomActionBarConfig: BottomActionBarConfig(
        //             enabled: false,
        //             backgroundColor: emojiColor,
        //             buttonColor: emojiColor),
        //         categoryViewConfig:
        //             CategoryViewConfig(backgroundColor: emojiColor)),
        //     onEmojiSelected: ((category, emoji) {
        //       setState(() {
        //         widget.controller.text.text =
        //             widget.controller.text.text + emoji.emoji;
        //       });
        //     }))
        : const SizedBox();
  }
}
