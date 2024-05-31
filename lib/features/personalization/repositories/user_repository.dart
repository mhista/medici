import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medici/providers.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../authentication/authentication_repository/authentication_repository.dart';
import '../../authentication/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db;
  final AuthenticationRepository _authRepo;
  final Ref _ref;
  UserRepository(
      {required FirebaseFirestore db,
      required AuthenticationRepository authRepo,
      required Ref ref})
      : _db = db,
        _authRepo = authRepo,
        _ref = ref;

  // SAVE USER DATA TO FIRESTORE
  Future<void> saveUser(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'Unable to save user details';
    }
  }

  // FETCH USER DATA FROM FIRESTORE BASED ON ID
  Future<UserModel> fetchUserData() async {
    try {
      final documentSnapshot =
          await _db.collection('Users').doc(_authRepo.authUser?.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatExceptions();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw 'user snapshot does not exist';
    }
  }

  // FETCH ALL USERS
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final snapshot = await _db
          .collection('Users')
          .where(FieldPath.documentId, isNotEqualTo: _authRepo.authUser?.uid)
          .get();

      final list = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return list;
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

  // UPDATE USER DATA IN FIRESTORE
  Future<void> updateUserData(UserModel user) async {
    try {
      await _db.collection('Users').doc(user.id).update(user.toMap());
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

  // UPDATE FIELD IN USERS COLLECTION
  Future<void> updateSingleField(Map<String, dynamic> map) async {
    try {
      await _db.collection('Users').doc(_authRepo.authUser?.uid).update(map);
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

  // REMOVE USER DATA FROM FIRESTORE
  Future<void> removeUserData(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
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

  // UPLOAD USER PROFILE IMAGE
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final url =
          _ref.read(firebaseStorageHandler).uploadImageFile(path, image);
      return url;
    } catch (e) {
      return e.toString();
    }
  }

  // FETCH USER DATA FROM FIRESTORE
  // SET USER ONLINE/OFFLINE STATE
  setUserState({required bool state, String? id}) async {
    await _db
        .collection('Users')
        .doc(id ?? _authRepo.authUser?.uid)
        .update({'isOnline': state});
    // await _db.collection('Users').doc(_authRepo.authUser?.uid)
  }

  Stream<bool> getOnlineStatus(String id) {
    final status = _db
        .collection('Users')
        .doc(id)
        .snapshots()
        .asyncMap((event) => UserModel.fromSnapshot(event).isOnline);
    return status;
  }
}
