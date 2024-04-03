import 'dart:convert';

class MainTextMatchedSubstrings {
  int? length;
  int? offset;
  MainTextMatchedSubstrings({
    this.length,
    this.offset,
  });

  MainTextMatchedSubstrings copyWith({
    int? length,
    int? offset,
  }) {
    return MainTextMatchedSubstrings(
      length: length ?? this.length,
      offset: offset ?? this.offset,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (length != null) {
      result.addAll({'length': length});
    }
    if (offset != null) {
      result.addAll({'offset': offset});
    }

    return result;
  }

  factory MainTextMatchedSubstrings.fromMap(Map<String, dynamic> map) {
    return MainTextMatchedSubstrings(
      length: map['length']?.toInt(),
      offset: map['offset']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MainTextMatchedSubstrings.fromJson(String source) =>
      MainTextMatchedSubstrings.fromMap(json.decode(source));

  @override
  String toString() =>
      'MainTextMatchedSubstrings(length: $length, offset: $offset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MainTextMatchedSubstrings &&
        other.length == length &&
        other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}
