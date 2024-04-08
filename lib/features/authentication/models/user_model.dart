import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  final bool isOnline;
  // List addresses;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.isOnline,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    bool? isOnline,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicture: profilePicture ?? this.profilePicture,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'profilePicture': profilePicture});
    result.addAll({'isOnline': isOnline});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      isOnline: map['isOnline'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '', isOnline: false,
        // addresses: [],
      );

// factory methof to create a user model from firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        isOnline: data['isOnline'] ?? false,
        // addresses: data['addresses'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }

  /// HELPER FUNCTIONS

  ///  gets the fullname
  String get fullName => '$firstName $lastName';

  // function to format the phone number
  String get formattedPhoneNumber => PFormatter.formatPhoneNumber(phoneNumber);

  // splitting fullname into firstname and lastname
  static List<String> splitFullName(fullName) => fullName.split(' ');

  // generating a username from the fullname
  static String generateUsername(fullName) {
    List<String> splitName = fullName.split(' ');
    String firstName = splitName[0].toLowerCase();
    String lastName = splitName.length > 1 ? splitName[1].toLowerCase() : '';

    String camelCaseUsername = '$firstName$lastName';
    String usernameWithPrefix = 'pik_$camelCaseUsername';
    return usernameWithPrefix;
  }

  //

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture, isOnline: $isOnline)';
  }
}
