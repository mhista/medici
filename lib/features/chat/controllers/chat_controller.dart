import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:medici/features/chat/models/chat_contact.dart';
import 'package:medici/features/chat/models/message_model.dart';
import 'package:medici/features/chat/repositories/chat_repository.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

import '../../authentication/models/user_model.dart';

class ChatContoller {
  final Ref ref;
  final ChatRepository chatRepository;
  ChatContoller(
    this.chatRepository, {
    required this.ref,
  });

  final text = TextEditingController();
  GlobalKey<FormState> chatFormKey = GlobalKey<FormState>();
  final unRepliedMessages =
      StateProvider<List<MessageModel>>((ref) => <MessageModel>[]);

// SEND MESSAGE TO USER
  Future<void> sendMessage(
      {required UserModel receiver, required MessageType type}) async {
    try {
      // check internet connection
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        return;
      }
      final messageText = text.text;
      // clear the textcontroller
      dispose();

      final user = ref.read(userProvider);
      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();
      // SAVE THE MESSAGE IN DATABASE
      final message = MessageModel(
          senderId: user.id,
          receiverId: receiver.id,
          text: messageText,
          type: type.name,
          timeSent: timeSent,
          messageId: uuid,
          isSeen: false);
      await chatRepository.sendMessage(message: message);
      // SAVE CHAT CONTACTS
      saveChatContacts(
          timeSent: timeSent,
          receiver: receiver,
          sender: user,
          message: message);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // SAVE THE MESSAGE AS A CHAT CONTACT TO BE SHOWN ON THE CHAT SCREEN

  Future<void> saveChatContacts(
      {required DateTime timeSent,
      required UserModel receiver,
      required UserModel sender,
      required MessageModel message}) async {
    try {
      // FOR SENDER
      var senderChatContact = ChatContact(
        timeSent: timeSent,
        lastMessage: message.text,
        user2: receiver,
        user1: sender,
      );
      // FOR RECEIVER
      final receiverChatContact = ChatContact(
          timeSent: timeSent,
          lastMessage: message.text,
          user2: sender,
          user1: receiver);
      await chatRepository.saveChatContacts(
          sender: senderChatContact, receiver: receiverChatContact);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // RETRIEVE ALL USER CURRENT MESSAGES AS STREAM
  Stream<List<ChatContact>> getUserChatContacts() {
    final chatContacts = chatRepository.getUserChatContacts();
    return chatContacts;
  }

  // RETRIEVE ALL MESSAGES BASED ON PARTICULAR USER
  Stream<List<MessageModel>> getAllUserMessages(String currentReceiverId) {
    final userMessages = chatRepository.getAllUserMessages(currentReceiverId);
    return userMessages;
  }

// GET ALL UNREPLIED MESSAGES
  Stream<List<MessageModel>> unrepliedMessages(String id) {
    final message = chatRepository.unrepliedMessages(id);

    return message;
  }

  // MARK ALL UNREAD MESSAGES AS READ
  void markAsRead(List<MessageModel> messageModels, String user2Id) async {
    // final receiverIds = messageModels.map((e) => e.messageId).toList();
    chatRepository.markAsRead(messageModels, user2Id);
  }

  // RETRIEVE ALL UNREAD MESSAGE

  // RETRIEVE SENT MESSAGE AS STREAM
  // Stream<MessageModel> getCurrentMessage(MessageModel message) {
  //   try {
  //     final message = chatRepository.getCurrentMessage(id);
  //   } catch (e) {
  //     return MessageModel.empty();
  //   }
  // }
  void dispose() {
    text.clear();
  }
}

// CHAT CONTROLLER METHOD PROVIDERS
final chatContactProvider = StreamProvider.autoDispose((ref) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.getUserChatContacts();
});

final chatMessagesProvider =
    StreamProvider.autoDispose.family((ref, String id) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.getAllUserMessages(id);
});

final unrepliedMessagesProvider =
    StreamProvider.autoDispose.family((ref, String id) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.unrepliedMessages(id);
});
