import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../providers.dart';
import '../../../../utils/validators/validation.dart';

class PSignupForm extends ConsumerWidget {
  const PSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signupControllerProvider);
    final hidePassword = ref.watch(controller.hidePassword.notifier).state;

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // first and last name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      PValidator.validateEmptyText('First Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: PTexts.firstname,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: PSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      PValidator.validateEmptyText('Last Name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: PTexts.lastname,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: PSizes.spaceBtwInputFields,
          ),
          // Username
          TextFormField(
            controller: controller.username,
            validator: (value) =>
                PValidator.validateEmptyText('Username', value),
            expands: false,
            decoration: const InputDecoration(
                labelText: PTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: PSizes.spaceBtwInputFields,
          ),
          // Email
          TextFormField(
            controller: controller.email,
            validator: PValidator.validateEmail,
            expands: false,
            decoration: const InputDecoration(
                labelText: PTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: PSizes.spaceBtwInputFields,
          ),
          // PhoneNumber
          TextFormField(
            controller: controller.phoneNumber,
            validator: PValidator.validatePhoneNumber,
            expands: false,
            decoration: const InputDecoration(
                labelText: PTexts.phoneNumber, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: PSizes.spaceBtwInputFields,
          ),
          // Password
          Consumer(builder: (context, WidgetRef ref, child) {
            return TextFormField(
              obscureText: hidePassword,
              controller: controller.password,
              validator: PValidator.validatePassword,
              expands: false,
              decoration: InputDecoration(
                  labelText: PTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                      onPressed: () => ref
                          .read(controller.hidePassword.notifier)
                          .update((state) => !hidePassword),
                      icon: Icon(
                          hidePassword ? Iconsax.eye_slash : Iconsax.eye))),
            );
          }),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          // Terms and condition

          // SignUp Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                child: const Text(PTexts.createAccount),
                onPressed: () => controller.signup()),
          ),
        ],
      ),
    );
  }
}
