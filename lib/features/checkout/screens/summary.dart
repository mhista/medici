import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/button/bottom_button.dart';
import 'package:medici/features/specialists/screens/specialist_detail.dart';
import 'package:medici/features/specialists/screens/widgets/specialist_heading.dart';
import 'package:medici/utils/constants/colors.dart';
import 'package:medici/utils/constants/sizes.dart';

class PaymentSummary extends ConsumerWidget {
  const PaymentSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Summary"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(PSizes.spaceBtwItems),
          child: Column(
            children: [
              const SpecialistHeading(),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: PSizes.spaceBtwItems,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date & Hour",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "August 24, 2023 | 10:00 AM",
                        style: Theme.of(context).textTheme.headlineMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: const Icon(
                      Iconsax.money5,
                      color: PColors.primary,
                    ),
                    title: Text(
                      "Cash",
                      style: Theme.of(context).textTheme.titleSmall!,
                    ),
                    trailing: TextButton(
                      onPressed: () {},
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
      bottomNavigationBar: BottomButton(text: "PAY NOW", onTap: () {}),
    );
  }
}
