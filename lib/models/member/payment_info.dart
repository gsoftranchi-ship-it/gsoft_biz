class PaymentInfo {
  final double admissionFee;
  final double membershipFee;
  final double discount;
  final double finalAmount;
  final double paidAmount;
  final double dueAmount;

  final String paymentMode;
  final String transactionId;
  final String receiptNumber;

  final DateTime? nextDueDate;

  final String remarks;

  const PaymentInfo({
    required this.admissionFee,
    required this.membershipFee,
    required this.discount,
    required this.finalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.paymentMode,
    required this.transactionId,
    required this.receiptNumber,
    this.nextDueDate,
    required this.remarks,
  });

  factory PaymentInfo.fromMap(Map<String, dynamic> map) {
    return PaymentInfo(
      admissionFee: (map['admissionFee'] ?? 0).toDouble(),
      membershipFee: (map['membershipFee'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      finalAmount: (map['finalAmount'] ?? 0).toDouble(),
      paidAmount: (map['paidAmount'] ?? 0).toDouble(),
      dueAmount: (map['dueAmount'] ?? 0).toDouble(),
      paymentMode: map['paymentMode'] ?? '',
      transactionId: map['transactionId'] ?? '',
      receiptNumber: map['receiptNumber'] ?? '',
      nextDueDate: map['nextDueDate'] != null
          ? DateTime.parse(map['nextDueDate'])
          : null,
      remarks: map['remarks'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'admissionFee': admissionFee,
      'membershipFee': membershipFee,
      'discount': discount,
      'finalAmount': finalAmount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'paymentMode': paymentMode,
      'transactionId': transactionId,
      'receiptNumber': receiptNumber,
      'nextDueDate': nextDueDate?.toIso8601String(),
      'remarks': remarks,
    };
  }

  PaymentInfo copyWith({
    double? admissionFee,
    double? membershipFee,
    double? discount,
    double? finalAmount,
    double? paidAmount,
    double? dueAmount,
    String? paymentMode,
    String? transactionId,
    String? receiptNumber,
    DateTime? nextDueDate,
    String? remarks,
  }) {
    return PaymentInfo(
      admissionFee: admissionFee ?? this.admissionFee,
      membershipFee: membershipFee ?? this.membershipFee,
      discount: discount ?? this.discount,
      finalAmount: finalAmount ?? this.finalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      paymentMode: paymentMode ?? this.paymentMode,
      transactionId: transactionId ?? this.transactionId,
      receiptNumber: receiptNumber ?? this.receiptNumber,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      remarks: remarks ?? this.remarks,
    );
  }
}