import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:medici/features/chat/models/ai_chat_model.dart';
import 'package:medici/features/personalization/controllers/user_controller.dart';
import 'package:medici/utils/local_storage/storage_utility.dart';
import 'package:uuid/uuid.dart';

import '../../../providers.dart';
import '../repositories/ai_chat_repository.dart';

final aiTextProvider = StateProvider<bool>((ref) => false);
final isFirstChat = StateProvider<bool>((ref) => false);
final messagedAi = StateProvider<bool>((ref) => false);
final scrollControl = StateProvider<bool>((ref) => false);

final chatSession = StateProvider<ChatSession?>((ref) => null);
final isAIResponding = StateProvider<ChatSession?>((ref) => null);

class AIChatController {
  final Ref ref;
  final AIChatRepository chatRepository;

  final text = TextEditingController();
  GlobalKey<FormState> chatFormKey = GlobalKey<FormState>();

  AIChatController(
    this.chatRepository, {
    required this.ref,
  });

  void init() async {
    ref.read(chatSession.notifier).update(
          (state) => ref.read(aiModel).startChat(
              // history:
              ),
        );
  }

  // send message to AI assitant
  Future<void> sendTextMessage() async {
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

      // final user = ref.read(userProvider);
      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();

      final aiMessage = AIChatModel(
          text: messageText, messageId: uuid, timeSent: timeSent, isUser: true);
      await chatRepository.sendMessage(message: aiMessage);

      final gemini = ref.read(chatSession);
      debugPrint(gemini.toString());
      final prompt = Content.text(messageText);
      // final schema = Schema.array(items: items);
      final response = await gemini?.sendMessage(
        prompt,
        // generationConfig: GenerationConfig(
        //   responseMimeType: 'application/json',
        // ),
      );
      debugPrint(response?.text);
      final timeSent2 = DateTime.now();
      var uuid2 = const Uuid().v4();
      if (response != null &&
          response.text != null &&
          response.text!.isNotEmpty) {
        debugPrint(response.text);

        final aiMessage2 = AIChatModel(
            text: response.text!,
            messageId: uuid2,
            timeSent: timeSent2,
            isUser: false);
        await chatRepository.sendMessage(message: aiMessage2);
        await HiveService.openBox(ref.read(userProvider).id);

        final hive = HiveService.instance();

        bool messagedAI =
            hive.get<bool>('messagedAi', defaultValue: true) ?? true;
        ref.read(messagedAi.notifier).state = messagedAI;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // send message to AI assitant
  Future<void> sendFirstTextMessage() async {
    try {
      // check internet connection
      final isConnected =
          await ref.watch(networkService.notifier).isConnected();
      if (!isConnected) {
        return;
      }

      // clear the textcontroller
      dispose();

      // final user = ref.read(userProvider);
      final timeSent = DateTime.now();
      var uuid = const Uuid().v4();
      if (!ref.read(isFirstChat)) {
        final aiMessage2 = AIChatModel(
            text:
                'Hello! My name is Medini, your friendly healthcare assistant. How can I assist you today? 😊',
            messageId: uuid,
            timeSent: timeSent,
            isUser: false);
        await chatRepository.sendMessage(message: aiMessage2);
        ref.read(messagedAi.notifier).state = true;

        return;
      }
      final aiMessage2 = AIChatModel(
          text:
              'Hello! My name is Medini, your friendly healthcare assistant. How can I assist you today? 😊',
          messageId: uuid,
          timeSent: timeSent,
          isUser: false);
      await chatRepository.sendMessage(message: aiMessage2);
      ref.read(messagedAi.notifier).state = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // RETRIEVE ALL AI MESSAGES
  Stream<List<AIChatModel>> getAImessages() {
    final userMessages = chatRepository.getAIMessages();
    return userMessages;
  }

// / UPDATES THE STATE OF THE TEXTPOVIDER WHEN THE STRING CHANGES IN TEXTEDITING CONTROLLER
  checkEmptyText() {
    text.addListener(() {
      bool hasNoText = text.text.isNotEmpty;
      // debugPrint(hasNoText.toString());
      ref.read(aiTextProvider.notifier).state = hasNoText;
    });
  }

  void dispose() {
    text.clear();
  }
}

//  stream provider to get all user messages
final aiMessagesProvider = StreamProvider((ref) {
  final chatControllerr = ref.watch(aiChatController);
  return chatControllerr.getAImessages();
});
