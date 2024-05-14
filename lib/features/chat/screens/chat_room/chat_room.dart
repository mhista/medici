import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
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
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 5),
            child: Row(
              children: [
                Flexible(
                  child: Form(
                    key: controller.chatFormKey,
                    child: MSearchBar(
                      textController: controller.text,
                      useSuffix: true,
                      hintText: 'Type Something...',
                      textFieldWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () => controller.sendMessageFile(
                                  receiver: user, type: MessageType.image),
                              icon: const Icon(Icons.camera_alt)),
                          // const SizedBox(
                          //   width: PSizes.spaceBtwItems / ,
                          // ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file)),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => controller.sendMessage(
                        receiver: user, type: MessageType.text),
                    icon: const Icon(Iconsax.send_1)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
