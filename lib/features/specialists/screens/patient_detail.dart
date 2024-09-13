import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/common/widgets/button/bottom_button.dart';
import 'package:medici/features/checkout/controllers/checkout_controller.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/sizes.dart';

import '../../../utils/validators/validation.dart';

class PatientDetailForm extends ConsumerWidget {
  const PatientDetailForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Patient Details"),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(PSizes.md),
              child: Column(
                children: [
                  // patient name
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Patient Name",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(fontWeightDelta: -1),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 1.5,
                      ),
                      TextFormField(
                        // controller: controller.firstName,
                        validator: (value) =>
                            PValidator.validateEmptyText('Patient Name', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Patient Name",
                            prefixIcon: Icon(Iconsax.user)),
                      ),
                    ],
                  ),
                  // geender
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(fontWeightDelta: -1),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 1.5,
                      ),
                      TextFormField(
                        // controller: controller.firstName,
                        validator: (value) =>
                            PValidator.validateEmptyText('Gender', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Gender",
                            prefixIcon: Icon(Iconsax.user_cirlce_add)),
                      ),
                    ],
                  ),
                  // age
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Age",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(fontWeightDelta: -1),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 1.5,
                      ),
                      TextFormField(
                        // controller: controller.firstName,
                        validator: (value) =>
                            PValidator.validateEmptyText('Your Age', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: "Your age",
                            prefixIcon: Icon(Iconsax.user_add)),
                      ),
                    ],
                  ),
                  // problem statement
                  const SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Write Your Problem",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .apply(fontWeightDelta: -1),
                      ),
                      const SizedBox(
                        height: PSizes.spaceBtwItems / 1.5,
                      ),
                      TextFormField(
                        // controller: controller.firstName,
                        validator: (value) => PValidator.validateEmptyText(
                            'Write Your Problem', value),
                        expands: false,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          hintText: "Write here....",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomButton(
          text: "Continue",
          onTap: () => ref.read(checkoutController).init().then(
            (v) {
              ref.read(canPopAfterSelect.notifier).state = true;
              return ref.read(checkoutController).selectPaymentModel(context);
            },
          ),
        ));
  }
}
