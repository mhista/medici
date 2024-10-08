import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final String messageEnum;

  MessageReply(
      {required this.message, required this.isMe, required this.messageEnum});

  static MessageReply empty() =>
      MessageReply(message: '', isMe: false, messageEnum: '');
}

final messageReplyProvider = StateProvider<MessageReply?>((ref) {
  return null;
});
