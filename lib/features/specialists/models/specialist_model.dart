import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'working_hour.dart';

class Doctor {
  String id;
  String name;
  String description;
  String noOfPatients;
  String specialty;
  String phoneNumber;
  String email;
  String address;
  String yearOfExp;
  double rating;
  // String review;
  List<WorkingHourModel>? workingHours;
  bool isVerified;
  String profileImage;
  String location;
  Doctor({
    required this.id,
    required this.name,
    required this.description,
    required this.noOfPatients,
    required this.specialty,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.yearOfExp,
    required this.rating,
    this.workingHours,
    required this.isVerified,
    required this.profileImage,
    required this.location,
  });
  static Doctor empty() => Doctor(
      id: "",
      name: "",
      description: "",
      noOfPatients: "",
      specialty: "",
      phoneNumber: "",
      email: "",
      address: "",
      yearOfExp: "",
      rating: 0,
      isVerified: false,
      profileImage: "",
      location: "");
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'noOfPatients': noOfPatients});
    result.addAll({'specialty': specialty});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'email': email});
    result.addAll({'address': address});
    result.addAll({'yearOfExp': yearOfExp});
    result.addAll({'rating': rating});
    workingHours != null
        ? result.addAll(
            {'workingHours': workingHours!.map((x) => x.toMap()).toList()})
        : [];

    result.addAll({'isVerified': isVerified});
    result.addAll({'profileImage': profileImage});
    result.addAll({'location': location});

    return result;
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      noOfPatients: map['noOfPatients'] ?? '',
      specialty: map['specialty'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      yearOfExp: map['yearOfExp'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      workingHours: map['workingHours'] != null
          ? List<WorkingHourModel>.from(
              map['workingHours']?.map((x) => WorkingHourModel.fromMap(x)))
          : null,
      isVerified: map['isVerified'] ?? false,
      profileImage: map['profileImage'] ?? '',
      location: map['location'] ?? '',
    );
  }
  // dOCTOR SNAPSHOT
  factory Doctor.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return Doctor.empty();
    final map = document.data()!;
    return Doctor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      noOfPatients: map['noOfPatients'] ?? '',
      specialty: map['specialty'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      yearOfExp: map['yearOfExp'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      workingHours: map['workingHours'] != null
          ? List<WorkingHourModel>.from(
              map['workingHours']?.map((x) => WorkingHourModel.fromMap(x)))
          : null,
      isVerified: map['isVerified'] ?? false,
      profileImage: map['profileImage'] ?? '',
      location: map['location'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());

  factory Doctor.fromJson(String source) => Doctor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, description: $description, noOfPatients: $noOfPatients, specialty: $specialty, phoneNumber: $phoneNumber, email: $email, address: $address, yearOfExp: $yearOfExp, rating: $rating, workingHours: $workingHours, isVerified: $isVerified, profileImage: $profileImage, location: $location)';
  }

  Doctor copyWith({
    String? id,
    String? name,
    String? description,
    String? noOfPatients,
    String? specialty,
    String? phoneNumber,
    String? email,
    String? address,
    String? yearOfExp,
    double? rating,
    List<WorkingHourModel>? workingHours,
    bool? isVerified,
    String? profileImage,
    String? location,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      noOfPatients: noOfPatients ?? this.noOfPatients,
      specialty: specialty ?? this.specialty,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      yearOfExp: yearOfExp ?? this.yearOfExp,
      rating: rating ?? this.rating,
      workingHours: workingHours ?? this.workingHours,
      isVerified: isVerified ?? this.isVerified,
      profileImage: profileImage ?? this.profileImage,
      location: location ?? this.location,
    );
  }
}
