import 'dart:convert';

class Terms {
  int? offset;
  String? value;
  Terms({
    this.offset,
    this.value,
  });

  Terms copyWith({
    int? offset,
    String? value,
  }) {
    return Terms(
      offset: offset ?? this.offset,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (offset != null) {
      result.addAll({'offset': offset});
    }
    if (value != null) {
      result.addAll({'value': value});
    }

    return result;
  }

  factory Terms.fromMap(Map<String, dynamic> map) {
    return Terms(
      offset: map['offset']?.toInt(),
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Terms.fromJson(String source) => Terms.fromMap(json.decode(source));

  @override
  String toString() => 'Terms(offset: $offset, value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Terms && other.offset == offset && other.value == value;
  }

  @override
  int get hashCode => offset.hashCode ^ value.hashCode;
}
