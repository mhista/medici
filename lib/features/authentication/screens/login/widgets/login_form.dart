import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:medici/providers.dart';
import 'package:medici/router.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';

class PLoginForm extends ConsumerWidget {
  const PLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(loginController);
    final hidePassword = ref.watch(controller.hidePassword.notifier).state;
    final remeberMe = ref.watch(controller.rememberMe.notifier).state;

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: PSizes.spaceBtwSections),
        child: Column(
          children: [
            // Email
            TextFormField(
              validator: PValidator.validateEmail,
              controller: controller.email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: PTexts.email),
            ),
            const SizedBox(
              height: PSizes.spaceBtwInputFields,
            ),

            //Password
            TextFormField(
              obscureText: hidePassword,
              validator: (value) =>
                  PValidator.validateEmptyText('Password', value),
              controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: PTexts.password,
                suffixIcon: IconButton(
                  onPressed: () => ref
                      .read(controller.hidePassword.notifier)
                      .update((state) => !hidePassword),
                  icon: Icon(hidePassword ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
            const SizedBox(
              height: PSizes.spaceBtwInputFields / 2,
            ),
            // Remeber me and forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remeber me
                Row(
                  children: [
                    Checkbox(
                      value: remeberMe,
                      onChanged: (value) => ref
                          .read(controller.rememberMe.notifier)
                          .update((state) => !remeberMe),
                    ),
                    const Text(PTexts.remember)
                  ],
                ),
                // forget password
                TextButton(
                  onPressed: () {},
                  child: const Text(PTexts.forgetPassword),
                )
              ],
            ),
            const SizedBox(
              height: PSizes.spaceBtwSections,
            ),
            // SignInButton
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.emailAndPassworSignIn(),
                child: const Text(PTexts.signIn),
              ),
            ),

            const SizedBox(height: PSizes.spaceBtwItems),
            // create account buttons
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => ref.read(goRouterProvider).goNamed('signup'),
                child: const Text(PTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
