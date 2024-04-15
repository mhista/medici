import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:medici/features/authentication/models/user_model.dart';

class ChatContact {
  final UserModel user1;
  final UserModel user2;
  final DateTime timeSent;
  final String lastMessage;
  ChatContact({
    required this.user1,
    required this.user2,
    required this.timeSent,
    required this.lastMessage,
  });

  static empty() => ChatContact(
      timeSent: DateTime.now(),
      lastMessage: '',
      user1: UserModel.empty(),
      user2: UserModel.empty());

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'user1': user1.toMap()});
    result.addAll({'user2': user2.toMap()});
    result.addAll({'timeSent': timeSent.millisecondsSinceEpoch});
    result.addAll({'lastMessage': lastMessage});

    return result;
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      user1: UserModel.fromMap(map['user1']),
      user2: UserModel.fromMap(map['user2']),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  // factory method to create a chatcontact model from firebase document snapshot
  factory ChatContact.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final map = document.data()!;
      return ChatContact(
        user1: UserModel.fromMap(map['user1']),
        user2: UserModel.fromMap(map['user2']),
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        lastMessage: map['lastMessage'] ?? '',
      );
    } else {
      return ChatContact.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory ChatContact.fromJson(String source) =>
      ChatContact.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatContact(user1: $user1, user2: $user2, timeSent: $timeSent, lastMessage: $lastMessage)';
  }
}
