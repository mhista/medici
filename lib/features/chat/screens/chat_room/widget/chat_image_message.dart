import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/chat/screens/chat_room/widget/video_player_container.dart';
import 'package:medici/utils/constants/file_formats.dart';

import '../../../../../common/styles/borderRadius.dart';
import '../../../../../common/widgets/shimmer/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class ChatTextImage extends StatelessWidget {
  const ChatTextImage({
    super.key,
    required this.isUser,
    required this.isDark,
    required this.text,
  });

  final bool isUser;
  final bool isDark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 200,
      decoration: BoxDecoration(
          color: isUser
              ? PColors.primary
              : isDark
                  ? PColors.darkerGrey
                  : PColors.grey,
          border: Border.all(width: 0.02, color: Colors.grey),
          borderRadius: chatBorderRadius(isUser)),
      child: Padding(
          padding: const EdgeInsets.only(
              top: PSizes.exs,
              left: PSizes.exs,
              right: PSizes.exs,
              bottom: PSizes.spaceBtwSections),
          child: ClipRRect(
            borderRadius: chatBorderRadius(isUser),
            child: videoFormats.contains(
                    text.split('.').last.split('?').first.toUpperCase())
                ? VideoPlayerContainer(videoUrl: text)
                : CachedNetworkImage(
                    width: 200,
                    imageUrl: text,
                    fit: BoxFit.contain,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const PShimmerEffect(
                      color: PColors.primary,
                      height: 300,
                      width: 200,
                      radius: 15,
                    ),
                  ),
          )),
    );
  }
}
