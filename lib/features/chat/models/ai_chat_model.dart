import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AIChatModel {
  final String text;
  final String messageId;
  final DateTime timeSent;
  final bool isUser;
  AIChatModel({
    required this.text,
    required this.messageId,
    required this.timeSent,
    required this.isUser,
  });

  static AIChatModel empty() => AIChatModel(
        text: '',
        messageId: '',
        timeSent: DateTime.now(),
        isUser: false,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'messageId': messageId});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'isUser': isUser});

    return result;
  }

  factory AIChatModel.fromMap(Map<String, dynamic> map) {
    return AIChatModel(
      text: map['text'] ?? '',
      messageId: map['messageId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      isUser: map['isUser'] ?? false,
    );
  }

  // factory method to create a message model from firebase document snapshot
  factory AIChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final map = document.data()!;
      return AIChatModel(
        text: map['text'] ?? '',
        messageId: map['messageId'] ?? '',
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        isUser: map['isUser'] ?? false,
      );
    } else {
      return AIChatModel.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory AIChatModel.fromJson(String source) =>
      AIChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AIChatModel(text: $text, messageId: $messageId, timeSent: $timeSent, isUser: $isUser)';
  }
}
