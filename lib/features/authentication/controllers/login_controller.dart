import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:medici/providers.dart';

import '../../../common/loaders/loaders.dart';
import '../authentication_repository/authentication_repository.dart';

class LoginController {
  final AuthenticationRepository authenticationRepository;
  final Ref ref;
  LoginController({required this.authenticationRepository, required this.ref});
  // VARIABLE
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  // final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // @override
  // void onInit() async {
  //   email.text = localStorage.read('remember_me_email');
  //   password.text = localStorage.read('remember_me_password');
  //   super.onInit();
  // }

  Future<void> emailAndPassworSignIn() async {
    try {
      // START LOADING
      // PFullScreenLoader.openLoadingDialog(
      //     'Logging in.... ', PImages.accountancy);
      // CHECK INTERNET CONNECTIVITY
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        // PFullScreenLoader.stopLoading();
        return;
      }

      // FORM VALIDATION
      if (!loginFormKey.currentState!.validate()) {
        // PFullScreenLoader.stopLoading();
        return;
      }
      // STORE REMEMBER ME
      // if (rememberMe.value) {
      //   // localStorage.writeIfNull('remember_me', true);
      //   localStorage.writeIfNull('remember_me_email', email.text.trim());
      //   localStorage.writeIfNull('remember_me_password', password.text.trim());
      // }
      // // LOGIN USER
      await authenticationRepository.loginWitheEmailAndPassword(
          email.text.trim(), password.text.trim());

      // REMOVE LOADER
      // PFullScreenLoader.stopLoading();

      // REDIRECT TO HOME
      authenticationRepository.screenRedirect();
    } catch (e) {
      // PFullScreenLoader.stopLoading();
      PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      // START LOADING
      // PFullScreenLoader.openLoadingDialog(
      //     'Logging in.... ', PImages.accountancy);
      // CHECK INTERNET CONNECTIVITY
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        // PFullScreenLoader.stopLoading();
        return;
      }
      debugPrint('signing');
      final userCredentials = await authenticationRepository.signInWithGoogle();
      debugPrint(userCredentials.user.toString());
      await ref.read(userController).saveUserRecord(userCredentials);
      // remove loader
      // PFullScreenLoader.stopLoading();

      // SHOW SUCCES MESSAGE
      // PLoaders.successSnackBar(title: 'Welcome back!');
      // MOVE TO VERIFY HOME SCREEN
      authenticationRepository.screenRedirect();
    } catch (e) {
      // PFullScreenLoader.stopLoading();
      debugPrint(e.toString());
      // PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }
}
