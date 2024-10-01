import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medici/features/chat/models/ai_chat_model.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/providers.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class AIChatRepository {
  final Ref ref;
  AIChatRepository({
    required this.ref,
  });

  Future<void> sendMessage({required AIChatModel message}) async {
    try {
      // SAVE IN THE SENDERS MESSAGE COLLECTION
      await ref
          .read(firestoreProvider)
          .collection('Users')
          .doc(ref.read(userProvider).id)
          .collection('AImessage')
          .doc(message.messageId)
          .set(message.toMap());
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

  Stream<List<AIChatModel>> getAIMessages() {
    try {
      return ref
          .read(firestoreProvider)
          .collection('Users')
          .doc(ref.read(userProvider).id)
          .collection('AImessage')
          .snapshots()
          .asyncMap((event) => event.docs
              .map((e) => AIChatModel.fromSnapshot(e))
              .sortedBy((element) => element.timeSent));
    } catch (e) {
      throw 'something went wrong!';
    }
  }

  Future<void> saveToLocal({required AIChatModel message}) async {
    try {
      // SAVE IN THE SENDERS MESSAGE COLLECTION
      await ref
          .read(firestoreProvider)
          .collection('Users')
          .doc(ref.read(userProvider).id)
          .collection('AImessage')
          .doc(message.messageId)
          .set(message.toMap());
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
