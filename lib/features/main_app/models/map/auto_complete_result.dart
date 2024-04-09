import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'matched_substrings.dart';
import 'structured_formatting.dart';
import 'terms.dart';

class AutoCompleteResult {
  String? description;
  List<MatchedSubstrings>? matchedSubStings;
  String placeId;

  String reference;
  StructuredFormatting? structuredFormatting;
  List<Terms>? terms;
  AutoCompleteResult({
    this.description,
    this.matchedSubStings,
    required this.placeId,
    required this.reference,
    this.structuredFormatting,
    this.terms,
  });

  AutoCompleteResult copyWith({
    String? description,
    List<MatchedSubstrings>? matchedSubStings,
    String? placeId,
    String? reference,
    StructuredFormatting? structuredFormatting,
    List<Terms>? terms,
  }) {
    return AutoCompleteResult(
      description: description ?? this.description,
      matchedSubStings: matchedSubStings ?? this.matchedSubStings,
      placeId: placeId ?? this.placeId,
      reference: reference ?? this.reference,
      structuredFormatting: structuredFormatting ?? this.structuredFormatting,
      terms: terms ?? this.terms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (description != null) {
      result.addAll({'description': description});
    }
    if (matchedSubStings != null) {
      result.addAll({
        'matchedSubStings': matchedSubStings!.map((x) => x.toMap()).toList()
      });
    }
    result.addAll({'placeId': placeId});
    result.addAll({'reference': reference});
    if (structuredFormatting != null) {
      result.addAll({'structuredFormatting': structuredFormatting!.toMap()});
    }
    if (terms != null) {
      result.addAll({'terms': terms!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory AutoCompleteResult.fromMap(Map<String, dynamic> map) {
    return AutoCompleteResult(
      description: map['description'],
      matchedSubStings: map['matchedSubStings'] != null
          ? List<MatchedSubstrings>.from(
              map['matchedSubStings']?.map((x) => MatchedSubstrings.fromMap(x)))
          : null,
      placeId: map['placeId'] ?? '',
      reference: map['reference'] ?? '',
      structuredFormatting: map['structuredFormatting'] != null
          ? StructuredFormatting.fromMap(map['structuredFormatting'])
          : null,
      terms: map['terms'] != null
          ? List<Terms>.from(map['terms']?.map((x) => Terms.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AutoCompleteResult.fromJson(String source) =>
      AutoCompleteResult.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AutoCompleteResult(description: $description, matchedSubStings: $matchedSubStings, placeId: $placeId, reference: $reference, structuredFormatting: $structuredFormatting, terms: $terms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AutoCompleteResult &&
        other.description == description &&
        listEquals(other.matchedSubStings, matchedSubStings) &&
        other.placeId == placeId &&
        other.reference == reference &&
        other.structuredFormatting == structuredFormatting &&
        listEquals(other.terms, terms);
  }

  @override
  int get hashCode {
    return description.hashCode ^
        matchedSubStings.hashCode ^
        placeId.hashCode ^
        reference.hashCode ^
        structuredFormatting.hashCode ^
        terms.hashCode;
  }
}
