import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/features/chat/controllers/chat_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../call/controllers/agora_engine_controller.dart';
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
    // final ref.watch(isCallOngoing) = ref.watch(isref.watch(isCallOngoing));
    _runsAfterBuild(ref);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (FocusNode().hasFocus) {
          FocusNode().unfocus();
          return;
        }
        ref.read(inChatRoom.notifier).update((state) => state = false);
        ref.read(goRouterProvider).pop();
      },
      child: Stack(
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
                                ? 'Dr ${receiver.lastName}'
                                : receiver.lastName,
                            subTitle: ref.watch(isCallOngoing)
                                ? "Call ongoing..."
                                : (!ref.watch(receiverPicked) &&
                                        ref
                                                .watch(callModelProvider)
                                                .receiverId ==
                                            ref.read(userProvider).id)
                                    ? 'Incoming call'
                                    : isOnline ?? false
                                        ? 'Online'
                                        : 'Offline'),
                        if (!ref.watch(isCallOngoing) ||
                            (!ref.watch(receiverPicked) &&
                                ref.watch(callModelProvider).receiverId ==
                                    ref.read(userProvider).id))
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
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return RoundedIcon(
                      marginRight: 0,
                      padding: 0,
                      height: 35,
                      width: 35,
                      radius: 35,
                      isPositioned: false,
                      iconData: ref.watch(isCallOngoing) ||
                              (!ref.watch(receiverPicked) &&
                                  ref.watch(callModelProvider).receiverId ==
                                      ref.read(userProvider).id)
                          ? Icons.call_end
                          : Icons.video_call,
                      hasBgColor: true,
                      hasIconColor: true,
                      color: PColors.light,
                      bgColor: ref.watch(isCallOngoing) ||
                              (!ref.watch(receiverPicked) &&
                                  ref.watch(callModelProvider).receiverId ==
                                      ref.read(userProvider).id)
                          ? Colors.red
                          : PColors.primary,
                      onPressed: ref.watch(isCallOngoing) ||
                              (!ref.watch(receiverPicked) &&
                                  ref.watch(callModelProvider).receiverId ==
                                      ref.read(userProvider).id)
                          ? () async {
                              final data = ref.read(callModelProvider);
                              ref
                                  .read(notificationProvider)
                                  .flutterLocalNotificationsPlugin
                                  .cancel(1);

                              ref
                                  .read(callController)
                                  .endCall(data.callerId, data.receiverId);
                            }
                          : () async {
                              ref.read(chatController).sendCallMessage(
                                  receiver: receiver,
                                  messageReply: messageReply,
                                  type: true);
                              ref.read(callController).makeCall(
                                  receiver: receiver,
                                  context: context,
                                  isVideo: true);
                            },
                      size: 18,
                    );
                  },
                ),
                const SizedBox(
                  width: PSizes.iconXs,
                ),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return RoundedIcon(
                      marginRight: 0,
                      padding: 0,
                      height: 35,
                      width: 35,
                      radius: 35,
                      isPositioned: false,
                      iconData: Iconsax.call,
                      hasBgColor: true,
                      hasIconColor: true,
                      color: PColors.light,
                      bgColor: ref.watch(isCallOngoing) ||
                              (!ref.watch(receiverPicked) &&
                                  ref.watch(callModelProvider).receiverId ==
                                      ref.read(userProvider).id)
                          ? Colors.green
                          : PColors.primary,
                      onPressed: ref.watch(isCallOngoing) ||
                              (!ref.watch(receiverPicked) &&
                                  ref.watch(callModelProvider).receiverId ==
                                      ref.read(userProvider).id)
                          ? () async {
                              final data = ref.watch(callModelProvider);

                              ref.read(callController).pickModelCall(data);
                            }
                          : () async {
                              ref.read(chatController).sendCallMessage(
                                  receiver: receiver,
                                  messageReply: messageReply,
                                  type: false);
                              ref.read(callController).makeCall(
                                  receiver: receiver,
                                  context: context,
                                  isVideo: false);
                            },
                      size: 18,
                    );
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

                ref.watch(isShowMessageReply)
                    ? MessageReplyPreview(
                        messageReply: messageReply!,
                        messageOwner: receiver.isDoctor
                            ? 'Dr ${receiver.fullName}'
                            : receiver.fullName)
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
          // CallPickupScreen(data: CallModel.empty())
        ],
      ),
    );
  }

  _runsAfterBuild(WidgetRef ref) async {
    await Future(() {
      // debugPrint(ref.read(inChatRoom).toString());
      ref.watch(callProvider).whenData((data) async {
        if (data.callEnded == true &&
            !ref.read(channelLeft) &&
            ref.read(isCallOngoing)) {
          await AgoraEngineController.endCall(ref.read(agoraEngine), ref, data);
          debugPrint('ended call');
          ref.read(callController).autoRedirectTimer(() {
            ref.read(engineInitialized.notifier).state = false;
            AgoraEngineController.release(ref.read(
              agoraEngine,
            ));
          }, 60);
        } else {
          ref.read(callModelProvider.notifier).state = data;
        }
      });
      // checks for a new message and marks it as read
      ref.watch(chatContactProvider).whenData((data) {
        if (ref.read(inChatRoom)) {
          final messages = ref
              .watch(unrepliedMessagesProvider(ref.watch(userChatProvider).id))
              .value
              ?.where((e) {
            return e.receiverId == (ref.read(userProvider).id);
          }).toList();
          ref
              .read(chatController)
              .markAsRead(messages!, ref.watch(userChatProvider).id);
        }
      });
      ref.read(loadingCompleteProvider.notifier).state = true;
    });
  }
}
