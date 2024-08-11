import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/call/screens/call_screen.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/models/user_model.dart';
import '../../../call/models/call_model.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/message_reply.dart';
import 'widget/chat_input_field.dart';
import 'widget/chat_list.dart';
import 'widget/emoji_picker.dart';
import 'widget/message_reply_preview.dart';

final loadingCompleteProvider = StateProvider<bool>((ref) {
  return false;
});

class ChatRoom extends ConsumerWidget {
  const ChatRoom({
    super.key,
    required this.receiver,
  });
  final UserModel receiver;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatController);
    final isDark = PHelperFunctions.isDarkMode(context);
    final isOnline = ref.watch(checkOnlineStatus(receiver.id)).value;
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    _runsAfterBuild(ref);
    final data = ref.watch(callModelProvider);
    final callEnds = ref.watch(callEnded);
    if (data.callId.isNotEmpty &&
        ref.read(userProvider).isOnline &&
        (data.callerId == ref.read(userProvider).id || callEnds == false)) {
      debugPrint(ref.read(callEnded).toString());

      return CallScreen(call: data);
    } else {
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
                      title: 'Dr ${receiver.fullName}',
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
              onPressed: () async {
                debugPrint(ref.read(loadingCompleteProvider).toString());
                // if (ref.read(loadingCompleteProvider)) {
                await ref
                    .read(callController)
                    .makeCall(receiver, context, true);
                ref.read(chatController).sendCallMessage(
                    receiver: receiver, messageReply: messageReply, type: true);
                // }
              },
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
              onPressed: () async {
                debugPrint(ref.read(loadingCompleteProvider).toString());

                if (ref.read(loadingCompleteProvider)) {
                  await ref
                      .read(callController)
                      .makeCall(receiver, context, false);
                  ref.read(chatController).sendCallMessage(
                      receiver: receiver,
                      messageReply: messageReply,
                      type: false);
                }
              },
            ),
            const SizedBox(
              width: PSizes.iconXs,
            ),
          ],
        ),
        body: Column(
          children: [
            // DAILY TIME
            Expanded(
                child: Stack(
              children: [
                ChatList(receiver: receiver),
              ],
            )),

            isShowMessageReply
                ? MessageReplyPreview(
                    messageReply: messageReply,
                    messageOwner: 'Dr ${receiver.fullName}')
                : const SizedBox(),
            ChatInputField(
              controller: controller,
              receiver: receiver,
              messageReply: messageReply,
            ),
            EmojiPickerr(controller: controller)
          ],
        ),
      );
    }
  }

  _runsAfterBuild(WidgetRef ref) async {
    await Future(() {});
    ref.watch(callProvider).whenData((callModel) {
      ref.read(callModelProvider.notifier).state = callModel;
      ref.read(loadingCompleteProvider.notifier).state = true;
    });
  }
}
