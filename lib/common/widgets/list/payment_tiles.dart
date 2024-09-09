import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/features/checkout/controllers/checkout_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/helpers/helper_functions.dart';

import '../../../features/checkout/models/payment_model.dart';
import '../../../router.dart';
import '../../../utils/constants/sizes.dart';
import '../containers/rounded_container.dart';

class PaymentTile extends ConsumerWidget {
  const PaymentTile({super.key, required this.paymentModel});

  final PaymentModel paymentModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        ref.read(selectedPaymentProvider.notifier).state = paymentModel;
        ref.read(goRouterProvider).pop();
        ref.read(goRouterProvider).goNamed("addcard");
      },
      leading: TRoundedContainer(
        width: 60,
        height: 60,
        backgroundColor: PHelperFunctions.isDarkMode(context)
            ? PColors.light
            : PColors.white,
        padding: const EdgeInsets.all(PSizes.sm),
        child: Image(
          image: AssetImage(paymentModel.image),
          fit: BoxFit.contain,
        ),
      ),
      title: Text(paymentModel.name),
      trailing: const Icon(Iconsax.arrow_right_14),
    );
  }
}
