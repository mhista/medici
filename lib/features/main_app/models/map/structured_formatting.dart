import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'main_text_matched_sub.dart';

class StructuredFormatting {
  String? mainText;
  List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;
  StructuredFormatting({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  StructuredFormatting copyWith({
    String? mainText,
    List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) {
    return StructuredFormatting(
      mainText: mainText ?? this.mainText,
      mainTextMatchedSubstrings:
          mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
      secondaryText: secondaryText ?? this.secondaryText,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (mainText != null) {
      result.addAll({'mainText': mainText});
    }
    if (mainTextMatchedSubstrings != null) {
      result.addAll({
        'mainTextMatchedSubstrings':
            mainTextMatchedSubstrings!.map((x) => x.toMap()).toList()
      });
    }
    if (secondaryText != null) {
      result.addAll({'secondaryText': secondaryText});
    }

    return result;
  }

  factory StructuredFormatting.fromMap(Map<String, dynamic> map) {
    return StructuredFormatting(
      mainText: map['mainText'],
      mainTextMatchedSubstrings: map['mainTextMatchedSubstrings'] != null
          ? List<MainTextMatchedSubstrings>.from(
              map['mainTextMatchedSubstrings']
                  ?.map((x) => MainTextMatchedSubstrings.fromMap(x)))
          : null,
      secondaryText: map['secondaryText'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StructuredFormatting.fromJson(String source) =>
      StructuredFormatting.fromMap(json.decode(source));

  @override
  String toString() =>
      'StructuredFormatting(mainText: $mainText, mainTextMatchedSubstrings: $mainTextMatchedSubstrings, secondaryText: $secondaryText)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StructuredFormatting &&
        other.mainText == mainText &&
        listEquals(
            other.mainTextMatchedSubstrings, mainTextMatchedSubstrings) &&
        other.secondaryText == secondaryText;
  }

  @override
  int get hashCode =>
      mainText.hashCode ^
      mainTextMatchedSubstrings.hashCode ^
      secondaryText.hashCode;
}
