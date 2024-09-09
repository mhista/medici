import 'dart:convert';

class PaymentSuccessful {
  final String successTitle;
  final String successMessage;
  final String patientName;
  final String consultantName;
  final String amount;
  final DateTime dateTime;
  PaymentSuccessful({
    required this.successTitle,
    required this.successMessage,
    required this.patientName,
    required this.consultantName,
    required this.amount,
    required this.dateTime,
  });

  static PaymentSuccessful empty() => PaymentSuccessful(
        successTitle: "",
        successMessage: "",
        patientName: "",
        consultantName: "",
        amount: "",
        dateTime: DateTime.now(),
      );
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'successTitle': successTitle});
    result.addAll({'successMessage': successMessage});
    result.addAll({'patientName': patientName});
    result.addAll({'consultantName': consultantName});
    result.addAll({'amount': amount});
    result.addAll({'dateTime': dateTime.millisecondsSinceEpoch});

    return result;
  }

  factory PaymentSuccessful.fromMap(Map<String, dynamic> map) {
    return PaymentSuccessful(
      successTitle: map['successTitle'] ?? '',
      successMessage: map['successMessage'] ?? '',
      patientName: map['patientName'] ?? '',
      consultantName: map['consultantName'] ?? '',
      amount: map['amount'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentSuccessful.fromJson(String source) =>
      PaymentSuccessful.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentSuccessful(successTitle: $successTitle, successMessage: $successMessage, patientName: $patientName, consultantName: $consultantName, amount: $amount, dateTime: $dateTime)';
  }

  PaymentSuccessful copyWith({
    String? successTitle,
    String? successMessage,
    String? patientName,
    String? consultantName,
    String? amount,
    DateTime? dateTime,
  }) {
    return PaymentSuccessful(
      successTitle: successTitle ?? this.successTitle,
      successMessage: successMessage ?? this.successMessage,
      patientName: patientName ?? this.patientName,
      consultantName: consultantName ?? this.consultantName,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
