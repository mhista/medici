import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:medici/features/authentication/authentication_repository/authentication_repository.dart';
import 'package:medici/features/personalization/repositories/user_repository.dart';
import 'package:medici/providers.dart';

import '../../../common/loaders/loaders.dart';
import '../models/user_model.dart';

class SignupController {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final Ref ref;
  SignupController(
      {required this.authenticationRepository,
      required this.userRepository,
      required this.ref});

// VARIABLES
  final hidePassword = StateProvider<bool>((ref) => true);
  final email = TextEditingController(); //email controller
  final lastName = TextEditingController(); //lastname controller
  final username = TextEditingController(); //username controller
  final firstName = TextEditingController(); //password controller
  final password = TextEditingController(); //password controller
  final phoneNumber = TextEditingController(); //phoneNumber controller
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  //USER REPOSITORY

// SIGNUP
  Future<void> signup() async {
    try {
      // START LOADING
      // PFullScreenLoader.openLoadingDialog(
      //     'Information being processed', PImages.google);
      // CHECK INTERNET CONNECTIVITY
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        // PFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!signupFormKey.currentState!.validate()) {
        // PFullScreenLoader.stopLoading();
        return;
      }

      // REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE IN THE FIREBASE
      final userCredential =
          await authenticationRepository.registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // SAVE AUTHENTICATED USER DATA IN THE FIREBASE FIRESTORE
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
          isOnline: false);
      await userRepository.saveUser(newUser);
      // remove loader
      // PFullScreenLoader.stopLoading();

      // SHOW SUCCES MESSAGE
      PLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created! verify email to continue');
      // MOVE TO VERIFY EMAIL ADDRESS
      // Get.to(() => VerifyEmailScreen(
      //       email: email.text.trim(),
      //     ));
    } catch (e) {
      // PFullScreenLoader.stopLoading();

      // SHOW GENERIC ERROR TO THE USER
      PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  void onClose() {
    email.dispose();
    lastName.dispose();
    username.dispose();
    firstName.dispose();
    password.dispose();
    phoneNumber.dispose();
  }
}
