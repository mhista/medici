import 'dart:convert';

class WorkingHourModel {
  String day;
  DateTime startTime;
  DateTime endTime;
  WorkingHourModel({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'day': day});
    result.addAll({'startTime': startTime.millisecondsSinceEpoch});
    result.addAll({'endTime': endTime.millisecondsSinceEpoch});

    return result;
  }

  factory WorkingHourModel.fromMap(Map<String, dynamic> map) {
    return WorkingHourModel(
      day: map['day'] ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(map['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(map['endTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkingHourModel.fromJson(String source) =>
      WorkingHourModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'WorkingHourModel(day: $day, startTime: $startTime, endTime: $endTime)';

  WorkingHourModel copyWith({
    String? day,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return WorkingHourModel(
      day: day ?? this.day,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
