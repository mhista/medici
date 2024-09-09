import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/images/circular_images.dart';
import '../../../../providers.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../call_screen.dart';

class UserVideoWidget extends ConsumerWidget {
  const UserVideoWidget({
    super.key,
    required this.widget,
    required this.remoteUid,
  });

  final CallScreen widget;

  final int? remoteUid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacingMultiple = (remoteUid == null) ? 6 : 1;
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          SizedBox(height: PSizes.spaceBtwSections * spacingMultiple),
          MCircularImage(
            imageUrl: PImages.dp2,
            isNetworkImage: false,
            height: (remoteUid == null) ? 100 : 70,
            width: (remoteUid == null) ? 100 : 70,
            backgroundColor: PColors.transparent,
          ),
          if (remoteUid == null)
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
