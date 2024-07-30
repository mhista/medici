import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/icons/rounded_icons.dart';
import 'package:medici/common/widgets/images/circular_images.dart';
import 'package:medici/features/call/controllers/call_controller.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../utils/constants/colors.dart';

class CallPickupScreen extends ConsumerWidget {
  const CallPickupScreen(this.scaffold, {super.key});
  final Widget scaffold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final call = ref.watch(callProvider);
    return call.when(
        data: (data) {
          if (!data.hasDialled) {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: PSizes.spaceBtwSections),
                child: Column(
                  children: [
                    Text(
                      'Incoming Call...',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwSections * 2,
                    ),
                    MCircularImage(imageUrl: data.callerPic),
                    const SizedBox(
                      height: PSizes.spaceBtwSections * 2,
                    ),
                    Text(
                      data.callerName,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(
                      height: PSizes.spaceBtwSections * 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedIcon(
                            color: Colors.redAccent,
                            isPositioned: false,
                            iconData: Icons.call_end_outlined,
                            onPressed: () {}),
                        const SizedBox(
                          width: PSizes.spaceBtwItems,
                        ),
                        RoundedIcon(
                            color: PColors.primary,
                            isPositioned: false,
                            iconData: Icons.call_outlined,
                            onPressed: () => context.goNamed(
                                  'video',
                                  extra: data,
                                ))
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return scaffold;
        },
        error: (error, __) => Center(
              child: Text(
                'Unable to place call',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white),
              ),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(
                color: PColors.primary,
              ),
            ));
  }
}
