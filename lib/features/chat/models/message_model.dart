import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String text;
  final String type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  static MessageModel empty() => MessageModel(
      senderId: '',
      receiverId: '',
      text: '',
      type: '',
      timeSent: DateTime.now(),
      messageId: '',
      isSeen: false);
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'text': text});
    result.addAll({'type': type});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'messageId': messageId});
    result.addAll({'isSeen': isSeen});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      type: map['type'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }

  // factory method to create a message model from firebase document snapshot
  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final map = document.data()!;
      return MessageModel(
        senderId: map['senderId'] ?? '',
        receiverId: map['receiverId'] ?? '',
        text: map['text'] ?? '',
        type: map['type'] ?? '',
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        messageId: map['messageId'] ?? '',
        isSeen: map['isSeen'] ?? false,
      );
    } else {
      return MessageModel.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(senderId: $senderId, receiverId: $receiverId, text: $text, type: $type, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen)';
  }
}
