import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/widgets/containers/rounded_container.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/circular_images.dart';
import 'package:medici/features/call/models/call_model.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class CallPickupScreen extends ConsumerWidget {
  const CallPickupScreen({super.key, required this.data});

  final CallModel data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = PHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: PColors.transparent.withOpacity(0.7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TRoundedContainer(
              child: TRoundedContainer(
                // backgroundColor: PColors.light,
                backgroundColor: isDark
                    ? PColors.darkerGrey.withOpacity(0.9)
                    : PColors.light.withOpacity(0.8),
                height: 260,
                width: 200,
                padding: const EdgeInsets.symmetric(
                    vertical: PSizes.spaceBtwSections),
                child: Column(
                  children: [
                    Text(
                      'Incoming Call...',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwItems,
                    ),
                    MCircularImage(
                      imageUrl: data.callerPic,
                      isNetworkImage: true,
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwItems * 1.3,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        data.callerName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Consumer(
                      builder: (_, WidgetRef ref, __) {
                        String callType = data.isVideo ? 'Video' : 'Voice';
                        return Text(
                          'is requesting a $callType call',
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwItems,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundedIcon(
                              hasBgColor: true,
                              color: PColors.white,
                              hasIconColor: true,
                              bgColor: Colors.redAccent,
                              isPositioned: false,
                              iconData: Icons.call_end_outlined,
                              onPressed: () {
                                ref
                                    .read(notificationProvider)
                                    .flutterLocalNotificationsPlugin
                                    .cancel(1);

                                ref
                                    .read(callController)
                                    .endCall(data.callerId, data.receiverId);
                              }),
                          const SizedBox(
                            width: PSizes.spaceBtwItems,
                          ),
                          RoundedIcon(
                              color: PColors.white,
                              hasIconColor: true,
                              hasBgColor: true,
                              bgColor: Colors.green,
                              isPositioned: false,
                              iconData: Icons.call_outlined,
                              onPressed: () =>
                                  ref.read(callController).pickModelCall(data))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // call.when(
    //     data: (data) {
    //       if (!data.hasDialled) {

    //       }
    //       return scaffold;
    //     },
    //     error: (error, __) => Center(
    //           child: Text(
    //             'Unable to place call',
    //             style: Theme.of(context)
    //                 .textTheme
    //                 .bodyMedium!
    //                 .apply(color: Colors.white),
    //           ),
    //         ),
    //     loading: () => const Center(
    //           child: CircularProgressIndicator(
    //             color: PColors.primary,
    //           ),
    //         ));
  }
}
