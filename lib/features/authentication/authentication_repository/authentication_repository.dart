import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AuthenticationRepository {
  final FirebaseAuth _auth;
  AuthenticationRepository({required FirebaseAuth auth}) : _auth = auth {
    onReady();
  }

  // VARIABLES
  // final deviceStorage = GetStorage();
  // GET AUTHENTICATED USER DATA
  User? get authUser => _auth.currentUser;

  // CALLED FROM THE main.dart on app launch
  void onReady() {
    // REMOVES THE NATIVE SPLASH SCREEN
    FlutterNativeSplash.remove();
    // REDIRECTS USER TO THE RIGHT SCREEN
    screenRedirect();
  }

  // FUNCTION TO SHOW DETERMINE THE SCREEN TO THE RIGHT SCREEN
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // if the user is logged in
      if (user.emailVerified) {
        // initialize user specific storage
        // await PLocalStorage.init(user.uid);

        // if users email is verified, navigate to the main navigation menu
        // Get.offAll(() => const NavigationMenu());
      } else {
        // if the user is not verified, redirect to the verify email screen
        // Get.offAll(() => const VerifyEmailScreen());
      }
    } else {
      // if (kDebugMode) {
      //   print(
      //       '---------------------------- GET STORAGE AUTH REPO ----------------------------');
      //   print(deviceStorage.read('isFirstTime'));
    }
    // LOCAL STORAGE
    // await deviceStorage.writeIfNull('isFirstTime', true);
    // await deviceStorage.read('isFirstTime') != true
    // Get.offAll(() => const LoginScreen());
    // : Get.offAll(() => const OnBoardingScreen());
  }

  //  ------------------------------- Email and Password signin --------------------------

  // SIGNIN EMAIL AUTHENTICATION

  // REGISTER EMAIL AUTHENTICATION
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // EMAIL VERIFICATION
  Future<void> verifyUserEmail() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // LOGIN USER
  Future<UserCredential> loginWitheEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // LOGOUT USER
  logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();

      // deviceStorage.write('remember_me', false);
      // Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }

  // REAUTHENTICATION
  Future<void> reAuthenticateWithEmailAndPassword(
      String email, String password) async {
    try {
      // CREATE CREDENTIALS
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      // REAUTHENTICATAE
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
  //  ---------------------------------- FEDERATED IDENTITY AND SOCIAL SIGN IN---------------

  // GOOGLE AUTHENTICATION
  Future<UserCredential> signInWithGoogle() async {
    try {
      // TRIGGER THE AUTHENTICATION FLOW
      debugPrint('signing');
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);
        return userCredential;
      }

      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      // OBTAIN THE AUTH DETAILS FROM THE REQUEST
      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;
      // CREATE A NEW CREDENTIAL
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      // ONCE SIGNED IN GET THE USER CREDENTIALS
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
  // FACEBOOK AUTHENTICATION

  //  ---------------------------------------OTHER VERIFICATION ---------------

  // DELETE USER
  Future<void> deleteAccount() async {
    try {
      // await UserRepository.instance.removeUserData(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'something went wrong, please try again';
    }
  }
}
