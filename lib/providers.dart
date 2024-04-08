import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/authentication/authentication_repository/authentication_repository.dart';
import 'package:medici/features/personalization/repositories/user_repository.dart';

import 'features/authentication/controllers/signup_controller.dart';

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
      authenticationRepository: authRepository, userRepository: userRepo);
});

// USER REPOSITORY
final userRepository = Provider((ref) {
  final db = ref.watch(firestoreProvider);
  final authRepo = ref.watch(authenticationProvider);
  return UserRepository(db: db, authRepo: authRepo);
});
