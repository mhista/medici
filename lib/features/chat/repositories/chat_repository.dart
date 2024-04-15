import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:medici/features/chat/models/chat_contact.dart';
import 'package:medici/features/chat/models/message_model.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_eceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class ChatRepository {
  final FirebaseFirestore db;
  final FirebaseAuth auth;
  ChatRepository({
    required this.db,
    required this.auth,
  });

  Future<void> sendMessage({required MessageModel message}) async {
    try {
      // SAVE IN THE SENDERS MESSAGE COLLECTION
      await db
          .collection('Users')
          .doc(message.senderId)
          .collection('Chats')
          .doc(message.receiverId)
          .collection('Messages')
          .doc(message.messageId)
          .set(message.toMap());
      // SAVE IN THE RECEIVERS MESSAGE COLLECTION
      await db
          .collection('Users')
          .doc(message.receiverId)
          .collection('Chats')
          .doc(message.senderId)
          .collection('Messages')
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

// SAVE CHAT CONTACTS AND DISPLAY ON SCREEN
  Future<void> saveChatContacts(
      {required ChatContact sender, required ChatContact receiver}) async {
    try {
      // SAVE IN THE SENDERS MESSAGE COLLECTION
      await db
          .collection('Users')
          .doc(sender.user1.id)
          .collection('Messages')
          .doc(sender.user2.id)
          .set(sender.toMap());

      // SAVE IN THE RECEIVERS MESSAGE COLLECTION

      await db
          .collection('Users')
          .doc(receiver.user1.id)
          .collection('Messages')
          .doc(receiver.user2.id)
          .set(receiver.toMap());
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

  // FETCH ALL  USER MESSAGES WHEN THE PARTICULAR CHAT IS OPENED
  Stream<List<MessageModel>> getAllUserMessages(String currentReceiversId) {
    try {
      return db
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .collection('Chats')
          .doc(currentReceiversId)
          .collection('Messages')
          .snapshots()
          .asyncMap((event) => event.docs
              .map((e) => MessageModel.fromSnapshot(e))
              .sortedBy((element) => element.timeSent));
    } catch (e) {
      throw 'something went wrong!';
    }
  }

// FETCH ALL  USER MESSAGES WHEN THE PARTICULAR CHAT IS OPENED
  Stream<List<MessageModel>> unrepliedMessages(String currentReceiversId) {
    try {
      return db
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .collection('Chats')
          .doc(currentReceiversId)
          .collection('Messages')
          .where('isSeen', isEqualTo: false)
          .snapshots()
          .asyncMap((event) => event.docs
              .map((e) => MessageModel.fromSnapshot(e))
              .sortedBy((element) => element.timeSent));
    } catch (e) {
      throw 'something went wrong!';
    }
  }

  // FETCH ALL CHAT CONTACTS TO DISPLAY ON SCREEN

  Stream<List<ChatContact>> getUserChatContacts() {
    try {
      return db
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .collection('Messages')
          .snapshots()
          .asyncMap((event) => event.docs
              .map((e) => ChatContact.fromSnapshot(e))
              .sortedBy((element) => element.timeSent)
              .reversed
              .toList());
    } catch (e) {
      throw 'something went wrong!';
    }
  }

  // MARK MESSAGES AS READ
  void markAsRead(List<MessageModel> messageModels, String user2Id) async {
    WriteBatch batch = db.batch();
    WriteBatch batch2 = db.batch();

    for (var message in messageModels) {
      var messages = db
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .collection('Chats')
          .doc(message.senderId)
          .collection('Messages')
          .doc(message.messageId);
      batch.update(messages, {'isSeen': true});
    }
    await batch2.commit();
    for (var message in messageModels) {
      var messages = db
          .collection('Users')
          .doc(user2Id)
          .collection('Chats')
          .doc(message.receiverId)
          .collection('Messages')
          .doc(message.messageId);
      batch.update(messages, {'isSeen': true});
    }
    await batch.commit();
  }
}
