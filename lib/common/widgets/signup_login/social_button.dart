import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:medici/providers.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class PSocialButton extends ConsumerWidget {
  const PSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: PColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: ref.read(authenticationProvider).logout,
            icon: const Image(
              image: AssetImage(PImages.facebook),
              height: PSizes.iconMd,
            ),
          ),
        ),
        const SizedBox(
          width: PSizes.spaceBtwItems,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: PColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: ref.read(loginController).signInWithGoogle,
            icon: const Image(
              image: AssetImage(PImages.google),
              height: PSizes.iconMd,
            ),
          ),
        ),
      ],
    );
  }
}
