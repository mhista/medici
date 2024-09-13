import 'dart:convert';

class Specialty {
  String name;
  String iconName;
  Specialty({
    required this.name,
    required this.iconName,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'iconName': iconName});

    return result;
  }

  factory Specialty.fromMap(Map<String, dynamic> map) {
    return Specialty(
      name: map['name'] ?? '',
      iconName: map['iconName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Specialty.fromJson(String source) =>
      Specialty.fromMap(json.decode(source));
}

List<Specialty> specialties = [
  Specialty(name: "Cardiologist", iconName: "heart"),
  Specialty(name: "Pediatrician", iconName: "child_care"),
  Specialty(name: "Orthopedic Surgeon", iconName: "healing"),
  Specialty(
      name: "Neurologist",
      iconName: "brain"), // custom icon or from a specialized pack
  Specialty(name: "Dermatologist", iconName: "spa"),
  Specialty(name: "Oncologist", iconName: "local_hospital"),
  Specialty(name: "Gynecologist", iconName: "pregnant_woman"),
  Specialty(name: "Psychiatrist", iconName: "psychology"),
  Specialty(name: "Ophthalmologist", iconName: "visibility"),
  Specialty(name: "Rheumatologist", iconName: "accessibility_new"),
  Specialty(name: "Endocrinologist", iconName: "insights"),
  Specialty(name: "Infectious Disease Specialist", iconName: "bug_report"),
  Specialty(name: "Geriatrician", iconName: "elderly"),
];
