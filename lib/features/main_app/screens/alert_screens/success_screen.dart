import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:medici/common/styles/spacing_styles.dart';
import 'package:medici/common/widgets/button/bottom_button.dart';
import 'package:medici/utils/constants/image_strings.dart';

import '../../../../common/layouts/gid_layout.dart';
import '../../../../router.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personalization/controllers/user_controller.dart';

class SuccessScreen1 extends ConsumerWidget {
  const SuccessScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: PSpacingStyle.successScreenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IMAGE
              Lottie.asset(PImages.success,
                  width: PHelperFunctions.screenWidth(context) * 0.6),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),
              // TITLE
              Text(
                'Payment Successful',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),

              Text(
                'You have successfully booked an appointment with',
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              Text(
                'Dr. Stanley',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(fontWeightDelta: 2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GridLayout(
                    itemCount: 4,
                    itemBuilder: (context, count) =>
                        paymentGridChildren(ref)[count]),
              ),
              // BUTTON
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => ref.read(goRouterProvider).pop(),
            child: Text(
              'Go to Home',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .apply(color: PColors.primary, fontWeightDelta: 2),
            ),
          ),
          SizedBox(
            width: 350,
            child: BottomButton(
              text: 'View Appointment',
              onTap: () => ref.read(goRouterProvider).pop(),
            ),
          )
        ],
      ),
    );
  }
}

class PaymentGridChild extends StatelessWidget {
  const PaymentGridChild({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PColors.primary,
        ),
        const SizedBox(
          width: PSizes.spaceBtwItems / 2,
        ),
        Text(
          text,
          style:
              Theme.of(context).textTheme.labelLarge!.apply(fontWeightDelta: 2),
        )
      ],
    );
  }
}

// Widget returnListWidget (int index, Widgetref)=>paymentGridChildren(ref)
List<Widget> paymentGridChildren(WidgetRef ref) => [
      PaymentGridChild(
          icon: Iconsax.profile_circle5, text: ref.read(userProvider).fullName),
      const PaymentGridChild(icon: Iconsax.money5, text: '\$20'),
      const PaymentGridChild(icon: Iconsax.calendar5, text: '16 Sep, 2024'),
      const PaymentGridChild(icon: Iconsax.clock5, text: '10:00 AM'),
    ];
