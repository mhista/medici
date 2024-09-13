import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medici/features/chat/models/chat_contact.dart';
import 'package:medici/features/chat/models/message_model.dart';
import 'package:medici/features/chat/models/message_reply.dart';
import 'package:medici/features/chat/repositories/chat_repository.dart';
import 'package:medici/providers.dart';
import 'package:medici/utils/constants/enums.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/constants/file_formats.dart';
import '../../authentication/models/user_model.dart';
import '../../personalization/controllers/user_controller.dart';

final chatContactMessages =
    StateProvider<List<ChatContact>>((ref) => <ChatContact>[]);

class ChatController {
  final Ref ref;
  final ChatRepository chatRepository;
  ChatController(
    this.chatRepository, {
    required this.ref,
  });

  final text = TextEditingController();
  // UPDATES ACCORDING TO THE STATE OF THE TEXT EDITING CONTROLLER
  final textProvider = StateProvider<bool>((ref) => false);

  GlobalKey<FormState> chatFormKey = GlobalKey<FormState>();

  final unRepliedMessages =
      StateProvider<List<MessageModel>>((ref) => <MessageModel>[]);

  final showEmojiContainer = StateProvider((ref) => false);

// UPDATES THE STATE OF THE TEXTPOVIDER WHEN THE STRING CHANGES IN TEXTEDITING CONTROLLER
  checkEmptyText() {
    text.addListener(() {
      bool hasNoText = text.text.isNotEmpty;
      // debugPrint(hasNoText.toString());
      ref.read(textProvider.notifier).state = hasNoText;
    });
  }

// SEND MESSAGE TO USER
  Future<void> sendTextMessage(
      {required UserModel receiver,
      required MessageType type,
      required MessageReply? messageReply}) async {
    try {
      // check internet connection
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        return;
      }
      if (text.text.isEmpty) {
        debugPrint('empty text');
        return;
      }
      final messageText = text.text;
      // clear the textcontroller
      dispose();

      final user = ref.read(userProvider);
      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();
      // SAVE THE MESSAGE IN DATABASE
      final message = formMessage(
          senderId: user.id,
          receiverId: receiver.id,
          text: messageText,
          type: type.name,
          messageID: uuid,
          timeSent: timeSent,
          repliedMessage: messageReply == null ? '' : messageReply.message,
          repliiedMessageType:
              messageReply == null ? '' : messageReply.messageEnum,
          repliedTo: messageReply == null
              ? ''
              : messageReply.isMe
                  ? user.username
                  : receiver.username);

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

// RECORD VOICE MESSAGE
  void sendVoiceNote(
      {required UserModel receiver,
      required String path,
      required MessageReply? messageReply}) async {
    try {
      final user = ref.read(userProvider);

      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();
      // SAVE THE MESSAGE IN DATABASE
      final message = formMessage(
          senderId: user.id,
          receiverId: receiver.id,
          text: path,
          type: MessageType.audio.name,
          messageID: uuid,
          timeSent: timeSent,
          repliedMessage: messageReply == null ? '' : messageReply.message,
          repliiedMessageType:
              messageReply == null ? '' : messageReply.messageEnum,
          repliedTo: messageReply == null
              ? ''
              : messageReply.isMe
                  ? user.username
                  : receiver.username);

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

  // UPLOAD IMAGE IN CHAT
  void sendMessageFile(
      {required UserModel receiver,
      required MessageReply? messageReply}) async {
    try {
      final user = ref.read(userProvider);
      final image = await ImagePicker().pickMedia(imageQuality: 70);
      // debugPrint(image!.name);

      if (image != null) {
        final timeSent = DateTime.now();
        var uuid = const Uuid().v4();
        // check if it is an video file

        final url =
            videoFormats.contains(image.name.split('.').last.toUpperCase());

        final imageuRL = await ref.read(firebaseStorageHandler).uploadImageFile(
            'Chat/${url ? MessageType.video.name : MessageType.image.name}/${user.id}/${receiver.id}/$uuid',
            image);

        // SAVE THE MESSAGE IN DATABASE
        final message = formMessage(
            senderId: user.id,
            receiverId: receiver.id,
            text: imageuRL,
            type: url ? MessageType.video.name : MessageType.image.name,
            messageID: uuid,
            timeSent: timeSent,
            repliedMessage: messageReply == null ? '' : messageReply.message,
            repliiedMessageType:
                messageReply == null ? '' : messageReply.messageEnum,
            repliedTo: messageReply == null
                ? ''
                : messageReply.isMe
                    ? user.username
                    : receiver.username);

        await chatRepository.sendMessage(message: message);
        // SAVE CHAT CONTACTS
        saveChatContacts(
            timeSent: timeSent,
            receiver: receiver,
            sender: user,
            message: message);
        debugPrint(image.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // SEND A MESSAGE WHEN A USER CALLS
  void sendCallMessage(
      {required UserModel receiver,
      required MessageReply? messageReply,
      required bool type}) async {
    try {
      // check internet connection
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        return;
      }

      final messageText = type == true ? "Video call" : "Voice call";
      // clear the textcontroller
      dispose();

      final user = ref.read(userProvider);
      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();
      // SAVE THE MESSAGE IN DATABASE
      final message = formMessage(
          senderId: user.id,
          receiverId: receiver.id,
          text: messageText,
          type: type == true
              ? MessageType.videoCall.name
              : MessageType.voiceCall.name,
          messageID: uuid,
          timeSent: timeSent,
          repliedMessage: messageReply == null ? '' : messageReply.message,
          repliiedMessageType:
              messageReply == null ? '' : messageReply.messageEnum,
          repliedTo: messageReply == null
              ? ''
              : messageReply.isMe
                  ? user.username
                  : receiver.username);

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
        lastMessage: message.type == MessageType.image.name
            ? '📷 Photo'
            : message.type == MessageType.video.name
                ? '🎥 Video'
                : message.type == MessageType.audio.name
                    ? '🔉 Audio'
                    : message.type == MessageType.gif.name
                        ? 'GIF'
                        : message.type == MessageType.videoCall.name
                            ? "📹 Video call"
                            : message.type == MessageType.voiceCall.name
                                ? "📞 Voice call"
                                : message.text,
        user2: receiver,
        user1: sender,
        messageId: message.messageId,
      );
      // FOR RECEIVER
      final receiverChatContact = ChatContact(
          timeSent: timeSent,
          lastMessage: message.type == MessageType.image.name
              ? '📷 Photo'
              : message.type == MessageType.video.name
                  ? '🎥 Video'
                  : message.type == MessageType.audio.name
                      ? '🔉 Audio'
                      : message.type == MessageType.gif.name
                          ? 'GIF'
                          : message.type == MessageType.videoCall.name
                              ? "📹 Video call"
                              : message.type == MessageType.voiceCall.name
                                  ? "📞 Voice call"
                                  : message.text,
          user2: sender,
          user1: receiver,
          messageId: message.messageId);
      await chatRepository.saveChatContacts(
          sender: senderChatContact, receiver: receiverChatContact);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  MessageModel formMessage(
      {required String senderId,
      required String receiverId,
      required String text,
      required String type,
      required String messageID,
      required DateTime timeSent,
      required String repliedMessage,
      required String repliiedMessageType,
      required String repliedTo}) {
    return MessageModel(
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        type: type,
        timeSent: timeSent,
        messageId: messageID,
        isSeen: false,
        repliedMessage: repliedMessage,
        repliedMessageType: repliiedMessageType,
        repliedTo: repliedTo);
  }

  // DELETE A MESSAGE
  Future<void> deleteMessage({required MessageModel message}) async {
    await chatRepository.deleteMessage(message: message);
    // PLoaders.customToast(message: 'message deleted', context: context);
  }

  // DELETE A MESSAGE
  void deleteChatContact(
      {required String receiverId, required String senderId}) async {
    await chatRepository.deleteChatContacts(
        senderId: senderId, receiverId: receiverId);
    // PLoaders.customToast(message: 'message deleted', context: context);
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
    chatRepository.markAsRead(messageModels, user2Id);
  }

  // RETRIEVE ALL UNREAD MESSAGE
  void dispose() {
    text.clear();
  }
}

// CHAT CONTROLLER METHOD PROVIDERS
// stream provider to get the last message sent to a user
final chatContactProvider = StreamProvider.autoDispose((ref) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.getUserChatContacts();
});

//  stream provider to get all user messages
final chatMessagesProvider =
    StreamProvider.autoDispose.family((ref, String id) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.getAllUserMessages(id);
});

// stream provider to get all uneplied messages
final unrepliedMessagesProvider =
    StreamProvider.autoDispose.family((ref, String id) {
  final chatControllerr = ref.watch(chatController);
  return chatControllerr.unrepliedMessages(id);
});

// final hasNoText =
//     StreamProvider.autoDispose.family((ref) {
//   final chatControllerr = ref.watch(chatController);
//   return chatControllerr.checkEmptyText();
// });
