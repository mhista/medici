import 'dart:convert';

class MatchedSubstrings {
  int? length;
  int? offset;
  MatchedSubstrings({
    this.length,
    this.offset,
  });

  MatchedSubstrings copyWith({
    int? length,
    int? offset,
  }) {
    return MatchedSubstrings(
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

  factory MatchedSubstrings.fromMap(Map<String, dynamic> map) {
    return MatchedSubstrings(
      length: map['length']?.toInt(),
      offset: map['offset']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MatchedSubstrings.fromJson(String source) =>
      MatchedSubstrings.fromMap(json.decode(source));

  @override
  String toString() => 'MatchedSubstrings(length: $length, offset: $offset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MatchedSubstrings &&
        other.length == length &&
        other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}
