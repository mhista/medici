import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medici/providers.dart';

import '../../../common/loaders/loaders.dart';
import '../../../utils/constants/sizes.dart';
import '../../authentication/authentication_repository/authentication_repository.dart';
import '../../authentication/models/user_model.dart';
import '../repositories/user_repository.dart';

class UserController {
  UserController(
      {required AuthenticationRepository authenticationRepository,
      required UserRepository userRepository,
      required Ref ref})
      : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _ref = ref {
    fetchUserRecord();
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final Ref _ref;

  // LOADER NOTIFIER
  // final profileLoading = false.obs;
  // final imageUploading = false.obs;

  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  final allUsers = StateProvider((ref) => <UserModel>[]);

// FETCH USER RECORD
  Future<void> fetchUserRecord() async {
    try {
      // profileLoading.value = true;

      final user = await _userRepository.fetchUserData();
      _ref.read(userProvider.notifier).update((state) => user);
    } catch (e) {
      _ref.read(userProvider.notifier).update((state) => UserModel.empty());
    } finally {
      // profileLoading.value = false;
    }
  }

// SAVE USER RECORD
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      await fetchUserRecord();
      await _userRepository.setUserState(true);
      final user = _ref.watch(userProvider);
      if (user.id.isEmpty) {
        // CONVERT THE DISPLAY NAME TO FIRST AND LAST NAME
        if (userCredential != null) {
          final nameParts =
              UserModel.splitFullName(userCredential.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredential.user!.displayName ?? '');

          // MAP DATA
          final user = UserModel(
              id: userCredential.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredential.user!.email ?? '',
              phoneNumber: userCredential.user!.phoneNumber ?? '',
              profilePicture: userCredential.user!.photoURL ?? '',
              isOnline: false);
          _ref.read(userProvider.notifier).update((state) => user);

          await _userRepository.saveUser(user);
        }
      }
    } catch (e) {
      // PFullScreenLoader.stopLoading();
      PLoaders.errorSnackBar(title: "Ooops!", message: e.toString());
    }
  }

// DELETE ACCOUNT POPUP
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(PSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: PSizes.lg),
            child: Text('Delete'),
          ),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

// REAUTHENTICATE USER BEFOR DELETING
  Future<void> reAuthenticateEmailAndPassword() async {
    // / START LOADING
    try {
      // PFullScreenLoader.openLoadingDialog('Processing.... ', PImages.astrology);
      // CHECK INTERNET CONNECTIVITY
      final isConnected =
          await _ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        // PFullScreenLoader.stopLoading();
        return;
      }
      // FORM VALIDATION
      if (!reAuthFormKey.currentState!.validate()) {
        // PFullScreenLoader.stopLoading();
        return;
      }

      await _authenticationRepository.reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      debugPrint('reauthenticated');
      await _authenticationRepository.deleteAccount();
      // PFullScreenLoader.stopLoading();
      // Get.offAll(() => const LoginScreen());
    } catch (e) {
      // PFullScreenLoader.stopLoading();

      // SHOW GENERIC ERROR TO THE USER
      PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // DELETE USER ACCOUNT
  void deleteUserAccount() async {
    try {
      // FIRST REAUTHENTICATE USER
      final provider = _authenticationRepository.authUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          // REVERIFY AUTH EMAIL
          await _authenticationRepository.signInWithGoogle();
          await _authenticationRepository.deleteAccount();
          // PFullScreenLoader.stopLoading();
          // Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          // PFullScreenLoader.stopLoading();
          // Get.offAll(() => const ReAuthUserScreen());
        }
      }
    } catch (e) {
      // PFullScreenLoader.stopLoading();

      // SHOW GENERIC ERROR TO THE USER
      PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // UPLOAD USER PROFILE PICTURE
  void uploadUserProfilePics() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxWidth: 512,
          maxHeight: 512);
      if (image != null) {
        // imageUploading.value = true;
        final imageUrl =
            await _userRepository.uploadImage('Users/Images/Profile', image);

        // UPDATE USER IMAGE IN FIRESTORE
        Map<String, dynamic> map = {'profilePicture': imageUrl};
        await _userRepository.updateSingleField(map);
        _ref.read(userProvider.notifier).update((state) {
          state.profilePicture = imageUrl;
          return state;
        });
        PLoaders.successSnackBar(
            title: 'Update successfull',
            message: 'Your profile image has been updated');
      }
    } catch (e) {
      // PFullScreenLoader.stopLoading();

      // SHOW GENERIC ERROR TO THE USER
      PLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // imageUploading.value = false;
    }
  }

// FETCH ALL USERS
  Future<List<UserModel>> fetchUsers() async {
    try {
      final users = await _userRepository.fetchAllUsers();
      return _ref.read(allUsers.notifier).update((state) {
        state.assignAll(users);
        return state;
      });
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  // SIGNOUT USER
  void signOut() async {
    await _userRepository.setUserState(false);
    await _authenticationRepository.logout();
    _ref.read(userProvider.notifier).update((state) => UserModel.empty());
  }

  // CHECK ONLINE/OFFLINE STATUS
  void setUserState(bool userState) async {
    final isConnected = await _ref.watch(networkService.notifier).isConnected();
    if (!isConnected) {
      _userRepository.setUserState(false);
      return;
    } else if (kIsWeb || isConnected) {
      _userRepository.setUserState(true);
      return;
    }
    _userRepository.setUserState(userState);
  }

  Stream<bool> getOnlineStatus(String id) {
    return _userRepository.getOnlineStatus(id);
  }
}
// USERCONTROLLER LASS ENDS HERE

// FETCH ALL USERS
final fetchAllUsersProvider = FutureProvider.autoDispose((ref) {
  final userControllerr = ref.watch(userController);
  return userControllerr.fetchUsers();
});

final checkOnlineStatus = StreamProvider.autoDispose.family((ref, String id) {
  final userControllerr = ref.watch(userController);
  return userControllerr.getOnlineStatus(id);
});
