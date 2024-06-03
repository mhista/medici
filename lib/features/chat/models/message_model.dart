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
  final String repliedMessage;

  final String repliedMessageType;
  final String repliedTo;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.repliedMessage,
    required this.repliedMessageType,
    required this.repliedTo,
  });

  static MessageModel empty() => MessageModel(
      senderId: '',
      receiverId: '',
      text: '',
      type: '',
      timeSent: DateTime.now(),
      messageId: '',
      isSeen: false,
      repliedMessage: '',
      repliedMessageType: '',
      repliedTo: '');
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'senderId': senderId});
    result.addAll({'receiverId': receiverId});
    result.addAll({'text': text});
    result.addAll({'type': type});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'messageId': messageId});
    result.addAll({'isSeen': isSeen});
    result.addAll({'repliedMessage': repliedMessage});
    result.addAll({'repliedMessageType': repliedMessageType});
    result.addAll({'repliedTo': repliedTo});

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
      repliedMessage: map['repliedMessage'] ?? '',
      repliedMessageType: map['repliedMessageType'] ?? '',
      repliedTo: map['repliedTo'] ?? '',
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
        repliedMessage: map['repliedMessage'] ?? '',
        repliedMessageType: map['repliedMessageType'] ?? '',
        repliedTo: map['repliedTo'] ?? '',
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
    return 'MessageModel(senderId: $senderId, receiverId: $receiverId, text: $text, type: $type, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen, repliedMessage: $repliedMessage, repliedMessageType: $repliedMessageType, repliedTo: $repliedTo)';
  }

  MessageModel copyWith({
    String? senderId,
    String? receiverId,
    String? text,
    String? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
    String? repliedMessage,
    String? repliedMessageType,
    String? repliedTo,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
      repliedMessage: repliedMessage ?? this.repliedMessage,
      repliedMessageType: repliedMessageType ?? this.repliedMessageType,
      repliedTo: repliedTo ?? this.repliedTo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessageModel &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.text == text &&
        other.type == type &&
        other.timeSent == timeSent &&
        other.messageId == messageId &&
        other.isSeen == isSeen &&
        other.repliedMessage == repliedMessage &&
        other.repliedMessageType == repliedMessageType &&
        other.repliedTo == repliedTo;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        text.hashCode ^
        type.hashCode ^
        timeSent.hashCode ^
        messageId.hashCode ^
        isSeen.hashCode ^
        repliedMessage.hashCode ^
        repliedMessageType.hashCode ^
        repliedTo.hashCode;
  }
}
