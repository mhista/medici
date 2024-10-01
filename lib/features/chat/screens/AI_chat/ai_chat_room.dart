import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'; // State management with Riverpod
import 'package:flutter/material.dart'; // Basic Flutter widgets
// Custom icon library
// Chat card widget
// Custom rounded icons widget
import 'package:medici/common/widgets/images/rounded_rect_image.dart'; // Custom rounded rectangle image widget
import 'package:medici/common/widgets/texts/title_subtitle.dart'; // Title and subtitle text widget
import 'package:medici/features/authentication/models/user_model.dart'; // User model
// Call controller for handling calls
import 'package:medici/features/chat/controllers/ai_chat_controller.dart';
import 'package:medici/features/chat/controllers/chat_controller.dart'; // Chat controller for handling messages
import 'package:medici/providers.dart'; // Providers for dependency injection
import 'package:medici/router.dart'; // Router for navigation
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart'; // Size constants for padding/margins
import '../../../../utils/constants/colors.dart'; // Color constants
import '../../../../utils/helpers/helper_functions.dart'; // Helper functions used in the app
// Agora engine controller for video calls
import '../../../personalization/controllers/user_controller.dart'; // User controller for managing user state
import '../../models/message_reply.dart'; // Model for message reply functionality
import 'ai_chat_list.dart';
import 'widgets/ai_chat_input_field.dart'; // Chat input field widget

// State provider for loading completion status
final loadingCompleteProvider = StateProvider<bool>((ref) => false);

// ChatRoom widget for managing the chat interface
class AIChatRoom extends ConsumerWidget {
  const AIChatRoom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(aiChatController); // Watching the chat controller for state
    final isDark = PHelperFunctions.isDarkMode(
        context); // Checking if dark mode is enabled
    // final receiver =
    //     ref.watch(userChatProvider); // Watching the receiver's user model
    // final isOnline = ref
    //     .watch(checkOnlineStatus(receiver.id))
    //     .value; // Checking the online status of the receiver
    final messageReply =
        ref.watch(messageReplyProvider); // Watching the message reply state

    // Runs after the build is complete
    _initializeAI(ref);

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
                  // if (receiver.isDoctor) {
                  //   await ref.read(specialistController).fetchSpecialist(receiver
                  //       .id); // Fetches specialist info if receiver is a doctor
                  //   ref.read(goRouterProvider).pushNamed(
                  //       "specialist"); // Navigates to the specialist page
                  // }
                },
                child:
                    _buildTitleAndSubtitle(), // Builds the title and subtitle for the app bar
              ),
              actions: _buildAppBarActions(ref, messageReply,
                  context), // Builds the action buttons in the app bar
            ),
            body: _buildBody(ref, messageReply,
                controller), // Builds the main body of the chat room
          ),
          // CallPickupScreen(data: CallModel.empty()) // Placeholder for call pickup screen (commented out)
        ],
      ),
    );
  }

  // Builds the title and subtitle for the chat room app bar
  Widget _buildTitleAndSubtitle() {
    return const Row(
      children: [
        ProfileImage1(
          image: PImages.logo, // Receiver's profile picture
          imageSize: 40, // Sets the size of the profile image
          radius: 40, // Sets the radius for circular cropping
          isNetworkImage:
              true, // Indicates if the image is fetched from the network
        ),
        SizedBox(width: PSizes.iconXs), // Adds space between image and text
        Stack(
          children: [
            TitleAndSubTitle(
              title: 'Medini', // Otherwise displays the last name
              subTitle:
                  'your AI healthcare assistant', // Displays online status
            ),
          ],
        ),
      ],
    );
  }

  // Builds the action buttons in the chat room app bar
  List<Widget> _buildAppBarActions(
      WidgetRef ref, MessageReply? messageReply, BuildContext context) {
    return [
      //  Adds final spacing between action buttons
    ];
  }

  // Makes a call (either video or voice) to the receiver
  // Future<void> _makeCall(WidgetRef ref, UserModel receiver,
  //     MessageReply? messageReply, BuildContext context, bool isVideo) async {
  //   ref.read(chatController).sendCallMessage(
  //       receiver: receiver, messageReply: messageReply, type: isVideo);
  //   ref
  //       .read(callController)
  //       .makeCall(receiver: receiver, context: context, isVideo: isVideo);
  // }

  // Builds the main body of the chat room, including the chat list and input field
  Widget _buildBody(
      WidgetRef ref, MessageReply? messageReply, AIChatController controller) {
    return Column(
      children: [
        const Expanded(
          child: Stack(
            children: [
              AIChatList(),
            ],
          ),
        ),

        AIChatInputField(
          controller: controller,
          messageReply: messageReply,
        ),
        // EmojiPickerr(controller: controller),
      ],
    );
  }

  // check if specialist is offline and prompt user to talk with AI
  // Future<void> _checkSpecialistOnlineStatus(
  //     UserModel receiver, WidgetRef ref) async {
  //   await Future.microtask(() {
  //     if (!receiver.isDoctor) {
  //       if (!receiver.isOnline) {}
  //       ref.read(showBotPrompt.notifier).state = true;
  //     }
  //   });
  //   // ref.read(aiChatController).sendFirstTextMessage();
  // }

  // initialize the gemini model
  Future<void> _initializeAI(WidgetRef ref) async {
    await Future.microtask(() {
      ref.read(aiChatController).init();
    });
  }
}
