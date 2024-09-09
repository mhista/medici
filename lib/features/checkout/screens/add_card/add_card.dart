import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart'
    as flutter_credit_card;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/common/widgets/button/bottom_button.dart';
import 'package:medici/features/checkout/controllers/card_controller.dart';
import 'package:medici/utils/constants/sizes.dart';
import 'package:u_credit_card/u_credit_card.dart';

import '../../../../providers.dart';
import '../../../../router.dart';
import '../../../../utils/constants/colors.dart';

class AddCard extends ConsumerWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(cardController);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Card"),
      ),
      body: Column(
        children: [
          CreditCardUi(
            cardHolderFullName: ref.watch(cardHolderNameProvider),
            cardNumber: ref.watch(cardNumberProvider),
            validThru: ref.watch(expiryDateProvider),
            cvvNumber: ref.watch(cvvCodeProvider),
            enableFlipping: true,
            currencySymbol: r'',
            cardType: CardType.debit,
            width: 350,
            placeNfcIconAtTheEnd: true,
            // showBalance: true,
            showValidFrom: false,
            topLeftColor: PColors.primary,
          ),
          // CreditCardWidget(
          //   // height: 175,c
          //   // width: 300,
          //   cardNumber: ref.watch(cardNumberProvider),
          //   expiryDate: ref.watch(expiryDateProvider),
          //   cardHolderName: ref.watch(cardHolderNameProvider),
          //   cvvCode: ref.watch(cvvCodeProvider),
          //   showBackView: false,
          //   onCreditCardWidgetChange: (creditCardBrand) {},
          //   cardBgColor: PColors.primary,
          //   glassmorphismConfig: Glassmorphism.defaultConfig(),
          //   enableFloatingCard: true,
          //   isHolderNameVisible: true,
          //   // cardType: ,
          // ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  flutter_credit_card.CreditCardForm(
                    formKey: controller.cardFormKey,
                    cardNumber: ref.read(cardHolderNameProvider),
                    expiryDate: ref.read(expiryDateProvider),
                    cardHolderName: ref.read(cardHolderNameProvider),
                    cvvCode: ref.read(cvvCodeProvider),
                    onCreditCardModelChange: controller.onCreditCardChange,
                  ),
                  const SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (onChanged) {},
                      ),
                      const SizedBox(
                        width: PSizes.spaceBtwItems,
                      ),
                      const Text("Save Card")
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButton(
        text: "CONTINUE",
        onTap: () => ref.read(goRouterProvider).goNamed("payment_summary"),
      ),
    );
  }
}
