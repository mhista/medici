import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String callId;
  final bool hasDialled;
  final bool isVideo;
  final int uniqueId;

  CallModel(
      {required this.callerId,
      required this.callerName,
      required this.callerPic,
      required this.receiverId,
      required this.receiverName,
      required this.callId,
      required this.hasDialled,
      required this.isVideo,
      required this.uniqueId});

  static CallModel empty() => CallModel(
      callerId: '',
      callerName: '',
      callerPic: '',
      receiverId: '',
      receiverName: '',
      callId: '',
      hasDialled: false,
      isVideo: false,
      uniqueId: 0);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'callerId': callerId});
    result.addAll({'callerName': callerName});
    result.addAll({'callerPic': callerPic});
    result.addAll({'receiverId': receiverId});
    result.addAll({'receiverName': receiverName});
    result.addAll({'callId': callId});
    result.addAll({'hasDialled': hasDialled});
    result.addAll({'uniqueId': uniqueId});

    return result;
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callerId: map['callerId'] ?? '',
      callerName: map['callerName'] ?? '',
      callerPic: map['callerPic'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      callId: map['callId'] ?? '',
      hasDialled: map['hasDialled'] ?? false,
      isVideo: map['isVideo'] ?? false,
      uniqueId: map['uniqueId']?.toInt() ?? 0,
    );
  }

  factory CallModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final map = document.data()!;
      return CallModel(
        callerId: map['callerId'] ?? '',
        callerName: map['callerName'] ?? '',
        callerPic: map['callerPic'] ?? '',
        receiverId: map['receiverId'] ?? '',
        receiverName: map['receiverName'] ?? '',
        callId: map['callId'] ?? '',
        hasDialled: map['hasDialled'] ?? false,
        isVideo: map['isVideo'] ?? false,
        uniqueId: map['uniqueId']?.toInt() ?? 0,
      );
    } else {
      return CallModel.empty();
    }
  }

  String toJson() => json.encode(toMap());

  factory CallModel.fromJson(String source) =>
      CallModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CallModel(callerId: $callerId, callerName: $callerName, callerPic: $callerPic, receiverId: $receiverId, receiverName: $receiverName, callId: $callId, hasDialled: $hasDialled, isVideo: $isVideo, uniqueId: $uniqueId)';
  }
}
