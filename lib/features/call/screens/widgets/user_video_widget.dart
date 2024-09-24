import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/features/call/controllers/agora_engine_controller.dart';

import '../../../../common/widgets/images/circular_images.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../models/call_model.dart';
import '../call_screen.dart';

class UserVideoWidget extends ConsumerWidget {
  const UserVideoWidget({
    super.key,
    required this.widget,
    required this.remoteUid,
    required this.call,
  });

  final CallScreen widget;
  final CallModel call;
  final int? remoteUid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacingMultiple =
        (remoteUid == null) || ref.watch(remoteUserMuted) || !call.isVideo
            ? 6
            : 1;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(height: PSizes.spaceBtwSections * spacingMultiple),
          MCircularImage(
            imageUrl: ref.read(userProvider).id == call.callerId
                ? ref.watch(userChatProvider).profilePicture
                : call.callerPic,
            isNetworkImage: true,
            height: (remoteUid == null) ? 100 : 70,
            width: (remoteUid == null) ? 100 : 70,
            backgroundColor: PColors.transparent,
          ),
          if (remoteUid == null || !call.isVideo)
            Column(
              children: [
                const SizedBox(height: PSizes.spaceBtwItems),
                Consumer(
                  builder: (_, WidgetRef ref, __) {
                    return Text(
                      ref.read(userProvider).id == widget.call.callerId
                          ? widget.call.receiverName
                          : widget.call.callerName,
                      style: const TextStyle(color: PColors.white),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                const SizedBox(height: PSizes.spaceBtwItems),
                const Text('Calling...'),
              ],
            ),
        ],
      ),
    );
  }
}
