import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/appbar/searchBar.dart';
import 'package:medici/common/widgets/cards/chat_card.dart';
import 'package:medici/common/widgets/cards/time_card.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/rounded_rect_image.dart';
import 'package:medici/common/widgets/texts/title_subtitle.dart';
import 'package:medici/utils/constants/image_strings.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'widget/chat_text.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = PHelperFunctions.isDarkMode(context);
    final screenWidth = PHelperFunctions.screenWidth(context);

    return Scaffold(
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
        title: const Row(
          children: [
            ProfileImage1(
              image: PImages.dp3,
              imageSize: 40,
              radius: 40,
            ),
            SizedBox(
              width: PSizes.iconXs,
            ),
            Stack(
              children: [
                TitleAndSubTitle(title: 'Dr Ann Baker', subTitle: 'Online'),
                Positioned(
                    left: 40,
                    bottom: 4,
                    child: OnlineIndicator(
                      size: 8,
                      isOnline: true,
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
      body: ListView(
        children: const [
          // DAILY TIME
          Center(
            child: Padding(
              padding: EdgeInsets.all(PSizes.iconXs),
              child: TimeCard(
                elevation: 0,
              ),
            ),
          ),
          ChatText(
              text: 'weuicuincuinuincuic incuinficnf nciuen', time: '08:34 AM'),
          ChatText(
            text:
                'xmiococ uhcbuibcuiwc iwcuiciucbic icuiciubcic icbuicbic bcuibcui',
            time: '08:40 AM',
            isUser: false,
          ),
          ChatText(
              text: 'iojwocircioec ioecjioe incuinficnf nciuen',
              time: '08:40 AM'),
          ChatText(
            text: 'weuicuincuinuincuic incuinficnf nciuen',
            time: '08:45 AM',
            isUser: false,
          ),
          ChatText(
              text: 'jrncui3nfuir f3rfiubrifr riufniurf iif iufb',
              time: '08:54 AM'),
          ChatText(
            text: 'uiru3rbfurf rfuir fjhf uy f3j f4jhh f',
            time: '08:59 AM',
            isUser: false,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 5),
        child: Row(
          children: [
            Flexible(
              child: MSearchBar(
                useSuffix: true,
                hintText: 'Type Somthing...',
                textFieldWidget:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Iconsax.send_1)),
          ],
        ),
      ),
    );
  }
}
