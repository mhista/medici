import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/widgets/button/bottom_button.dart';
import 'package:medici/features/checkout/controllers/checkout_controller.dart';
import 'package:medici/features/specialists/screens/widgets/specialist_heading.dart';
import 'package:medici/router.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../../../providers.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../specialists/controllers/specialist_controller.dart';

class PaymentSummary extends ConsumerWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentModel = ref.watch(selectedPaymentProvider);
    final doctor = ref.watch(specialistProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Summary"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.spaceBtwItems),
          child: Column(
            children: [
              SpecialistHeading(
                doctor: doctor,
              ),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: PSizes.spaceBtwItems * 1.7,
              ),
              Column(
                children: [
                  const SummaryInfoText(
                      firstText: 'Date & Hour',
                      secondText: 'August 24, 2023 | 10:00 AM'),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const SummaryInfoText(
                      firstText: 'Appointment type', secondText: 'Onsite'),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const SummaryInfoText(
                      firstText: 'Doctors Location',
                      secondText: 'Rumuola, Portharcourt Nigeria'),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const SummaryInfoText(
                      firstText: 'Your Location',
                      secondText: 'Rumudara, Portharcourt Nigeria'),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const SummaryInfoText(firstText: 'Total', secondText: '\$20'),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems * 1.7,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
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
                    title: Text(
                      paymentModel.name,
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        ref.read(canPopAfterSelect.notifier).state = false;
                        ref
                            .read(checkoutController)
                            .selectPaymentModel(context);
                      },
                      child: Text(
                        "Change",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: PColors.primary.withOpacity(0.7)),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        return BottomButton(
            text: ref.watch(isLoading) ? 'PROCESSING' : "PAY NOW",
            onTap: () {
              ref.read(isLoading.notifier).state = true;
              Timer(const Duration(seconds: 3), () {
                ref.read(isLoading.notifier).state = false;
                ref.read(goRouterProvider).goNamed('success_payment');
              });
            });
      }),
    );
  }
}

class SummaryInfoText extends StatelessWidget {
  const SummaryInfoText({
    super.key,
    required this.firstText,
    required this.secondText,
  });
  final String firstText, secondText;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          firstText,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          secondText,
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ],
    );
  }
}
