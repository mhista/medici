import 'package:hooks_riverpod/hooks_riverpod.dart'; // State management with Riverpod
import 'package:flutter/material.dart'; // Basic Flutter widgets
import 'package:iconsax/iconsax.dart'; // Custom icon library
import 'package:medici/common/widgets/cards/chat_card.dart'; // Chat card widget
import 'package:medici/common/widgets/icons/rounded_icons.dart'; // Custom rounded icons widget
import 'package:medici/common/widgets/images/rounded_rect_image.dart'; // Custom rounded rectangle image widget
import 'package:medici/common/widgets/texts/title_subtitle.dart'; // Title and subtitle text widget
import 'package:medici/features/authentication/models/user_model.dart'; // User model
import 'package:medici/features/call/controllers/call_controller.dart'; // Call controller for handling calls
import 'package:medici/features/chat/controllers/chat_controller.dart'; // Chat controller for handling messages
import 'package:medici/features/chat/screens/chat_room/widget/ai_prompt_container.dart';
import 'package:medici/providers.dart'; // Providers for dependency injection
import 'package:medici/router.dart'; // Router for navigation
import 'package:medici/utils/constants/sizes.dart'; // Size constants for padding/margins
import '../../../../utils/constants/colors.dart'; // Color constants
import '../../../../utils/helpers/helper_functions.dart'; // Helper functions used in the app
import '../../../call/controllers/agora_engine_controller.dart'; // Agora engine controller for video calls
import '../../../personalization/controllers/user_controller.dart'; // User controller for managing user state
import '../../models/message_reply.dart'; // Model for message reply functionality
import 'widget/chat_input_field.dart'; // Chat input field widget
import 'widget/chat_list.dart'; // Chat list widget
import 'widget/emoji_picker.dart'; // Emoji picker widget
import 'widget/message_reply_preview.dart'; // Message reply preview widget

// State provider for loading completion status
final loadingCompleteProvider = StateProvider<bool>((ref) => false);

// ChatRoom widget for managing the chat interface
class ChatRoom extends ConsumerWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(chatController); // Watching the chat controller for state
    final isDark = PHelperFunctions.isDarkMode(
        context); // Checking if dark mode is enabled
    final receiver =
        ref.watch(userChatProvider); // Watching the receiver's user model
    final isOnline = ref
        .watch(checkOnlineStatus(receiver.id))
        .value; // Checking the online status of the receiver
    final messageReply =
        ref.watch(messageReplyProvider); // Watching the message reply state

    // Runs after the build is complete
    _runsAfterBuild(ref);

    // checks if the specialist is online
    _checkSpecialistOnlineStatus(receiver, ref);

    return PopScope(
      canPop: false, // Prevents the chat room from being popped without control
      onPopInvokedWithResult: (didPop, result) {
        if (FocusNode().hasFocus) {
          FocusNode().unfocus(); // Unfocuses the keyboard if it's open
          return;
        }
        ref.read(inChatRoom.notifier).state =
            false; // Updates the in-chat state
        ref
            .read(goRouterProvider)
            .pop(); // Navigates back to the previous screen
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset:
                true, // Prevents keyboard from resizing the entire screen
            appBar: AppBar(
              elevation: 2, // Adds slight elevation to the app bar
              backgroundColor: isDark
                  ? PColors.dark.withOpacity(
                      0.4) // Adjusts background color based on dark mode
                  : PColors.light.withOpacity(0.4),
              leading: IconButton(
                onPressed: Navigator.of(context)
                    .pop, // Navigates back when back button is pressed
                icon: const Icon(Icons.arrow_back_ios_new),
                color: isDark
                    ? PColors.light
                    : PColors.dark, // Adjusts icon color based on dark mode
              ),
              leadingWidth: 25, // Sets the width for the leading icon
              title: GestureDetector(
                onTap: () async {
                  if (receiver.isDoctor) {
                    await ref.read(specialistController).fetchSpecialist(receiver
                        .id); // Fetches specialist info if receiver is a doctor
                    ref.read(goRouterProvider).pushNamed(
                        "specialist"); // Navigates to the specialist page
                  }
                },
                child: _buildTitleAndSubtitle(receiver,
                    isOnline), // Builds the title and subtitle for the app bar
              ),
              actions: _buildAppBarActions(ref, receiver, messageReply,
                  context), // Builds the action buttons in the app bar
            ),
            body: _buildBody(ref, receiver, messageReply,
                controller), // Builds the main body of the chat room
          ),
          // CallPickupScreen(data: CallModel.empty()) // Placeholder for call pickup screen (commented out)
        ],
      ),
    );
  }

  // Builds the title and subtitle for the chat room app bar
  Widget _buildTitleAndSubtitle(UserModel receiver, bool? isOnline) {
    return Row(
      children: [
        ProfileImage1(
          image: receiver.profilePicture, // Receiver's profile picture
          imageSize: 40, // Sets the size of the profile image
          radius: 40, // Sets the radius for circular cropping
          isNetworkImage:
              true, // Indicates if the image is fetched from the network
        ),
        const SizedBox(
            width: PSizes.iconXs), // Adds space between image and text
        Stack(
          children: [
            TitleAndSubTitle(
              title: receiver.isDoctor
                  ? 'Dr ${receiver.lastName}' // Displays "Dr" if the receiver is a doctor
                  : receiver.lastName, // Otherwise displays the last name
              subTitle: isOnline == true
                  ? 'Online'
                  : 'Offline', // Displays online status
            ),
            if (isOnline != null)
              Positioned(
                left: 43,
                bottom: 4,
                child: OnlineIndicator(
                    size: 8,
                    isOnline:
                        isOnline), // Displays an online indicator if available
              ),
          ],
        ),
      ],
    );
  }

  // Builds the action buttons in the chat room app bar
  List<Widget> _buildAppBarActions(WidgetRef ref, UserModel receiver,
      MessageReply? messageReply, BuildContext context) {
    return [
      Consumer(
        builder: (_, WidgetRef ref, __) {
          return RoundedIcon(
            marginRight: 0,
            padding: 0,
            height: 35,
            width: 35,
            radius: 35,
            size: 18,
            isPositioned: false,
            hasBgColor: true,
            hasIconColor: true,
            iconData: ref.watch(isCallOngoing) ||
                    (!ref.watch(receiverPicked) &&
                        ref.watch(callModelProvider).receiverId ==
                            ref.read(userProvider).id)
                ? Icons.call_end // Shows the call end icon if a call is ongoing
                : Icons.video_call, // Otherwise shows the video call icon
            bgColor: ref.watch(isCallOngoing) ||
                    (!ref.watch(receiverPicked) &&
                        ref.watch(callModelProvider).receiverId ==
                            ref.read(userProvider).id)
                ? Colors.red // Red background for call end button
                : PColors.primary, // Primary color for video call button
            onPressed: () async {
              if (ref.watch(isCallOngoing) ||
                  (!ref.watch(receiverPicked) &&
                      ref.watch(callModelProvider).receiverId ==
                          ref.read(userProvider).id)) {
                final data = ref.read(callModelProvider);
                ref
                    .read(notificationProvider)
                    .flutterLocalNotificationsPlugin
                    .cancel(1); // Cancels the call notification
                ref
                    .read(callController)
                    .endCall(data.callerId, data.receiverId); // Ends the call
              } else {
                await _makeCall(ref, receiver, messageReply, context,
                    true); // Initiates a video call
              }
            },
          );
        },
      ),
      const SizedBox(
          width: PSizes.iconXs), // Adds spacing between action buttons
      Consumer(
        builder: (_, WidgetRef ref, __) {
          return RoundedIcon(
            marginRight: 0,
            padding: 0,
            height: 35,
            width: 35,
            radius: 35,
            size: 18,
            isPositioned: false,
            hasBgColor: true,
            hasIconColor: true,
            iconData: Iconsax.call, // Icon for voice call
            bgColor: ref.watch(isCallOngoing) ||
                    (!ref.watch(receiverPicked) &&
                        ref.watch(callModelProvider).receiverId ==
                            ref.read(userProvider).id)
                ? Colors.green // Green background for ongoing calls
                : PColors.primary, // Primary color for initiating a call
            onPressed: () async {
              if (ref.watch(isCallOngoing) ||
                  (!ref.watch(receiverPicked) &&
                      ref.watch(callModelProvider).receiverId ==
                          ref.read(userProvider).id)) {
                final data = ref.watch(callModelProvider);
                ref
                    .read(callController)
                    .pickModelCall(data); // Picks up an incoming call
              } else {
                await _makeCall(ref, receiver, messageReply, context,
                    false); // Initiates a voice call
              }
            },
          );
        },
      ),
      const SizedBox(
          width: PSizes.iconXs), // Adds final spacing between action buttons
    ];
  }

  // Makes a call (either video or voice) to the receiver
  Future<void> _makeCall(WidgetRef ref, UserModel receiver,
      MessageReply? messageReply, BuildContext context, bool isVideo) async {
    ref.read(chatController).sendCallMessage(
        receiver: receiver, messageReply: messageReply, type: isVideo);
    ref
        .read(callController)
        .makeCall(receiver: receiver, context: context, isVideo: isVideo);
  }

  // Builds the main body of the chat room, including the chat list and input field
  Widget _buildBody(WidgetRef ref, UserModel receiver,
      MessageReply? messageReply, ChatController controller) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ChatList(receiver: receiver),
            ],
          ),
        ),
        if (ref.watch(isShowMessageReply))
          MessageReplyPreview(
            messageReply: messageReply!,
            messageOwner: receiver.isDoctor
                ? 'Dr ${receiver.fullName}'
                : receiver.fullName,
          ),
        // TODO: watch when the specialist is offline
        // if (ref.watch(showBotPrompt)) const AiPromptContainer(),
        ChatInputField(
          controller: controller,
          receiver: receiver,
          messageReply: messageReply,
        ),
        EmojiPickerr(controller: controller),
      ],
    );
  }

  // Function that runs after the build method completes
  Future<void> _runsAfterBuild(WidgetRef ref) async {
    await Future.microtask(() {
      ref.watch(callProvider).whenData((data) async {
        if (data.callEnded == true &&
            !ref.read(channelLeft) &&
            ref.read(isCallOngoing)) {
          await AgoraEngineController.endCall(ref.read(agoraEngine), ref, data);
          debugPrint('ended call');
          ref.read(callController).autoRedirectTimer(() {
            ref.read(engineInitialized.notifier).state = false;
            AgoraEngineController.release(ref.read(agoraEngine));
          }, 60);
        } else {
          ref.read(callModelProvider.notifier).state = data;
        }
      });

      ref.watch(chatContactProvider).whenData((data) {
        if (ref.read(inChatRoom)) {
          final messages = ref
              .watch(unrepliedMessagesProvider(ref.watch(userChatProvider).id))
              .value
              ?.where((e) => e.receiverId == ref.read(userProvider).id)
              .toList();
          ref
              .read(chatController)
              .markAsRead(messages!, ref.watch(userChatProvider).id);
        }
      });

      ref.read(loadingCompleteProvider.notifier).state = true;
    });
  }

  // check if specialist is offline and prompt user to talk with AI
  Future<void> _checkSpecialistOnlineStatus(
      UserModel receiver, WidgetRef ref) async {
    await Future.microtask(() {
      if (ref.watch(userChatProvider).isDoctor) {
        if (!ref.watch(userChatProvider).isOnline) {}
        ref.read(showBotPrompt.notifier).state = true;
      }
    });
  }
}
