import 'dart:convert';

class SecondaryTextMatchedSubstrings {
  int? length;
  int? offset;
  SecondaryTextMatchedSubstrings({
    this.length,
    this.offset,
  });

  SecondaryTextMatchedSubstrings copyWith({
    int? length,
    int? offset,
  }) {
    return SecondaryTextMatchedSubstrings(
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

  factory SecondaryTextMatchedSubstrings.fromMap(Map<String, dynamic> map) {
    return SecondaryTextMatchedSubstrings(
      length: map['length']?.toInt(),
      offset: map['offset']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SecondaryTextMatchedSubstrings.fromJson(String source) =>
      SecondaryTextMatchedSubstrings.fromMap(json.decode(source));

  @override
  String toString() =>
      'SecondaryTextMatchedSubstrings(length: $length, offset: $offset)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecondaryTextMatchedSubstrings &&
        other.length == length &&
        other.offset == offset;
  }

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}
