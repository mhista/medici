import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/authentication/authentication_repository/authentication_repository.dart';
import 'package:medici/features/authentication/controllers/login_controller.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/features/personalization/repositories/user_repository.dart';
import 'package:medici/utils/helpers/network_manager.dart';

import 'features/authentication/controllers/signup_controller.dart';
import 'features/authentication/models/user_model.dart';

// OBSERVABLE USERMODEL
StateProvider<UserModel> userProvider =
    StateProvider<UserModel>((ref) => UserModel.empty());

// REPOSITORIES
// FIREBASE REPOSITORIES
final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

// AUTHENTICATION REPOSITORY
final authenticationProvider = Provider(
    (ref) => AuthenticationRepository(auth: ref.read(firebaseAuthProvider)));

// CONTROLLERS
// SIGNUP CONTROLLER
final signupControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authenticationProvider);
  final userRepo = ref.watch(userRepository);
  return SignupController(
      authenticationRepository: authRepository,
      userRepository: userRepo,
      ref: ref);
});

// LOGIN CONTROLLER
final loginController = Provider((ref) => LoginController(
    authenticationRepository: ref.watch(authenticationProvider), ref: ref));

// USER REPOSITORY
final userRepository = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  final authRepo = ref.watch(authenticationProvider);
  return UserRepository(db: db, authRepo: authRepo);
});

// USER CONTROLLER
final userController = Provider((ref) => UserController(
    authenticationRepository: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepository),
    ref: ref));

// NETWORK CONNECTIVITY SERVICE
final networkService =
    StateNotifierProvider<NetworkManager, ConnectivityResult>(
        (ref) => NetworkManager());
// CONTACT REPOSITORY
// final contactRepository = FutureProvider(  
//     (ref) => SelectContactRepository(firestore: ref.watch(firestoreProvider)));
