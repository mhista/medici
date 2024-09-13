import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatController);
    final isDark = PHelperFunctions.isDarkMode(context);
    final receiver = ref.watch(userChatProvider);
    final isOnline = ref.watch(checkOnlineStatus(receiver.id)).value;
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    _runsAfterBuild(ref);

    // return ref.watch(callProvider).when(
    //       // skipError: true,
    //       skipLoadingOnRefresh: true,
    //       skipLoadingOnReload: true,
    //       data: (data) {
    //         if (data.callId.isNotEmpty &&
    //             ref.read(userProvider).isOnline &&
    //             (data.callerId == ref.read(userProvider).id ||
    //                 callEnds == false)) {
    //           return CallScreen(call: data);
    // } else {
    return Stack(
      children: [
        Scaffold(
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
            title: GestureDetector(
              onTap: () async {
                if (receiver.isDoctor) {
                  await ref
                      .read(specialistController)
                      .fetchSpecialist(receiver.id);
                  ref.read(goRouterProvider).pushNamed("specialist");
                }
              },
              child: Row(
                children: [
                  ProfileImage1(
                    image: receiver.profilePicture,
                    imageSize: 40,
                    radius: 40,
                    isNetworkImage: true,
                  ),
                  const SizedBox(
                    width: PSizes.iconXs,
                  ),
                  Stack(
                    children: [
                      TitleAndSubTitle(
                          title: receiver.isDoctor
                              ? 'Dr ${receiver.fullName}'
                              : receiver.fullName,
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
                  ref.read(chatController).sendCallMessage(
                      receiver: receiver,
                      messageReply: messageReply,
                      type: true);
                  ref.read(callController).makeCall(
                      receiver: receiver, context: context, isVideo: true);
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
                  ref.read(chatController).sendCallMessage(
                      receiver: receiver,
                      messageReply: messageReply,
                      type: false);
                  ref.read(callController).makeCall(
                      receiver: receiver, context: context, isVideo: false);
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
        ),
      ],
    );
  }

  _runsAfterBuild(WidgetRef ref) async {
    await Future(() {
      ref.read(loadingCompleteProvider.notifier).state = true;
    });
  }
}
