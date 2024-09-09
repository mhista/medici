import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardNumberProvider = StateProvider<String>((ref) => "");
final expiryDateProvider = StateProvider<String>((ref) => "");
final cardHolderNameProvider = StateProvider<String>((ref) => "");
final cvvCodeProvider = StateProvider<String>((ref) => "");
final isCvvFocusedProvider = StateProvider<bool>((ref) => false);
final useGlassMorphismProvider = StateProvider<bool>((ref) => false);
final useBackgroundImageProvider = StateProvider<bool>((ref) => false);
final useFloatingAnimationProvider = StateProvider<bool>((ref) => false);

class CardController {
  final Ref ref;
  GlobalKey<FormState> cardFormKey = GlobalKey<FormState>();

  CardController({required this.ref});

  void onCreditCardChange(CreditCardModel creditCardModel) {
    ref.read(cardNumberProvider.notifier).state = creditCardModel.cardNumber;
    ref.read(expiryDateProvider.notifier).state = creditCardModel.expiryDate;
    ref.read(cardHolderNameProvider.notifier).state =
        creditCardModel.cardHolderName;
    ref.read(cvvCodeProvider.notifier).state = creditCardModel.cvvCode;
    ref.read(isCvvFocusedProvider.notifier).state =
        creditCardModel.isCvvFocused;
  }
}
