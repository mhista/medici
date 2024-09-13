import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/checkout/models/payment_success.dart';

import '../../../common/widgets/headings/section_heading.dart';
import '../../../common/widgets/list/payment_tiles.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../models/payment_model.dart';

final selectedPaymentProvider = StateProvider<PaymentModel>((ref) {
  return PaymentModel.empty();
});

final paymentSuccessProvider = StateProvider<PaymentSuccessful>((ref) {
  return PaymentSuccessful.empty();
});
final canPopAfterSelect = StateProvider<bool>((ref) => true);
final isLoading = StateProvider<bool>((ref) => false);

class CheckoutController {
  final Ref ref;

  CheckoutController({required this.ref});

  Future<void> init() async {
    ref.read(selectedPaymentProvider.notifier).state =
        PaymentModel(name: 'Paystack', image: PImages.paystack);
  }

  Future<dynamic> selectPaymentModel(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(PSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                title: 'Select Payment Method',
                showActionButton: false,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.creditCard.name,
                    image: PImages.creditCard),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.paystack.name,
                    image: PImages.paystack),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.paypal.name, image: PImages.paypal),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.applePay.name,
                    image: PImages.applePay),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.googlePay.name, image: PImages.google),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              PaymentTile(
                paymentModel: PaymentModel(
                    name: PaymentMethods.visa.name, image: PImages.visa),
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems / 2,
              ),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSuccessfulPayment() {
    // ref.read(paymentSuccessProvider.notifier).state = PaymentSuccessful();
  }
}
