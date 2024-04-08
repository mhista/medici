import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/containers/container_tile.dart';
import 'package:medici/features/main_app/screens/chat_room/chat_room.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:medici/utils/constants/text_strings.dart';
import 'package:routemaster/routemaster.dart';

import '../../../../utils/helpers/helper_functions.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        children: [
          // SEARCH BAR
          MSearchBar(
            hintText: PTexts.chatSearchText,
            useSuffix: true,
            useBorder: false,
            color: PColors.primary.withOpacity(0.5),
            hasColor: true,
          ),
          const SizedBox(
            height: PSizes.spaceBtwItems,
          ),
          Padding(
            padding: const EdgeInsets.all(PSizes.spaceBtwItems),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ChatCard(
                        color: isDark ? PColors.dark : PColors.light,
                        title: 'Dr John Rodriguez',
                        subTitle: 'Hello, how can i help you?',
                        image: PImages.dp2,
                        recent: false,
                        onPressed: () => context.go('/messages/chat'));
                  },
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: PSizes.spaceBtwItems / 2),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
