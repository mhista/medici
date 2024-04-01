// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:pickafrika/common/loaders/loaders.dart';
// import 'package:pickafrika/data/repositories/authentication_repository/authentication_repository.dart';
// import 'package:pickafrika/features/authentication/models/user_model.dart';
// import 'package:pickafrika/features/authentication/screens/signup/verify_email.dart';
// import 'package:pickafrika/utils/constants/image_strings.dart';
// import 'package:pickafrika/utils/popups/fullscreen_loader.dart';

// import '../../../../data/repositories/user/user_repository.dart';
// import '../../../../utils/helpers/network_manager.dart';

// class SignupController extends GetxController {
//   static SignupController get instance => Get.find();

// // VARIABLES
//   final hidePassword = true.obs; //observable for hiding/showing passwords
//   final privacyPolicy = false.obs; //observable for privacy policy
//   final email = TextEditingController(); //email controller
//   final lastName = TextEditingController(); //lastname controller
//   final username = TextEditingController(); //username controller
//   final firstName = TextEditingController(); //password controller
//   final password = TextEditingController(); //password controller
//   final phoneNumber = TextEditingController(); //phoneNumber controller
//   GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
//   final userRepository = Get.put(UserRepository());
//   //USER REPOSITORY

// // SIGNUP
//   Future<void> signup() async {
//     try {
//       // START LOADING
//       PFullScreenLoader.openLoadingDialog(
//           'Information being processed', PImages.loading);
//       // CHECK INTERNET CONNECTIVITY
//       final isConnected = await NetworkManager.instance.isConnected();
//       if (!isConnected) {
//         PFullScreenLoader.stopLoading();
//         return;
//       }

//       // FORM VALIDATION
//       if (!signupFormKey.currentState!.validate()) {
//         PFullScreenLoader.stopLoading();
//         return;
//       }

//       // PRIVACY POLICY CHECK
//       if (!privacyPolicy.value) {
//         PLoaders.warningSnackBar(
//             title: 'Accept Privacy Policy',
//             message:
//                 'To create an account, you must have to read and accept the Privacy Policy & Terms of Use');
//         PFullScreenLoader.stopLoading();

//         return;
//       }
//       // REGISTER USER IN THE FIREBASE AUTHENTICATION & SAVE IN THE FIREBASE
//       final userCredential = await AuthenticationRepository.instance
//           .registerWithEmailAndPassword(
//               email.text.trim(), password.text.trim());

//       // SAVE AUTHENTICATED USER DATA IN THE FIREBASE FIRESTORE
//       final newUser = UserModel(
//           id: userCredential.user!.uid,
//           firstName: firstName.text.trim(),
//           lastName: lastName.text.trim(),
//           username: username.text.trim(),
//           email: email.text.trim(),
//           phoneNumber: phoneNumber.text.trim(),
//           profilePicture: '');
//       await userRepository.saveUser(newUser);
//       // remove loader
//       PFullScreenLoader.stopLoading();

//       // SHOW SUCCES MESSAGE
//       PLoaders.successSnackBar(
//           title: 'Congratulations',
//           message: 'Your account has been created! verify email to continue');
//       // MOVE TO VERIFY EMAIL ADDRESS
//       Get.to(() => VerifyEmailScreen(
//             email: email.text.trim(),
//           ));
//     } catch (e) {
//       PFullScreenLoader.stopLoading();

//       // SHOW GENERIC ERROR TO THE USER
//       PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     }
//   }

//   @override
//   void onClose() {
//     email.dispose();
//     lastName.dispose();
//     username.dispose();
//     firstName.dispose();
//     password.dispose();
//     phoneNumber.dispose();
//     super.onClose();
//   }
// }
