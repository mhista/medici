import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/call/models/call_model.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class CallRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  CallRepository({required this.auth, required this.db});

  Future<void> makeCall(
      CallModel senderCallData, CallModel receiverCallData) async {
    try {
      // SAVE IN THE SENDERS MESSAGE COLLECTION
      await db
          .collection('Calls')
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      // SAVE IN THE RECEIVERS MESSAGE COLLECTION
      await db
          .collection('Calls')
          .doc(receiverCallData.receiverId)
          .set(receiverCallData.toMap());
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

  Stream<CallModel> getCallStream() {
    return db
        .collection('Calls')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .asyncMap((event) => CallModel.fromSnapshot(event));
  }
}
