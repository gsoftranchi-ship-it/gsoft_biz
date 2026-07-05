class FeeModel {
  final String feeId;
  final String gymId;
  final String memberId;

  final double amount;
  final double paidAmount;
  final double dueAmount;

  final DateTime feeDate;
  final DateTime? dueDate;

  final String paymentMode;
  final String remarks;

  final bool isPaid;
  final bool isActive;

  final int version;

  const FeeModel({
    required this.feeId,
    required this.gymId,
    required this.memberId,
    required this.amount,
    required this.paidAmount,
    required this.dueAmount,
    required this.feeDate,
    this.dueDate,
    required this.paymentMode,
    required this.remarks,
    required this.isPaid,
    required this.isActive,
    required this.version,
  });

  factory FeeModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return FeeModel(
      feeId: map['feeId'] ?? id,
      gymId: map['gymId'] ?? '',
      memberId: map['memberId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      paidAmount: (map['paidAmount'] ?? 0).toDouble(),
      dueAmount: (map['dueAmount'] ?? 0).toDouble(),
      feeDate: map['feeDate'] != null
          ? DateTime.parse(map['feeDate'])
          : DateTime.now(),
      dueDate: map['dueDate'] != null
          ? DateTime.parse(map['dueDate'])
          : null,
      paymentMode: map['paymentMode'] ?? '',
      remarks: map['remarks'] ?? '',
      isPaid: map['isPaid'] ?? false,
      isActive: map['isActive'] ?? true,
      version: map['version'] ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'feeId': feeId,
      'gymId': gymId,
      'memberId': memberId,
      'amount': amount,
      'paidAmount': paidAmount,
      'dueAmount': dueAmount,
      'feeDate': feeDate.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'paymentMode': paymentMode,
      'remarks': remarks,
      'isPaid': isPaid,
      'isActive': isActive,
      'version': version,
    };
  }

  FeeModel copyWith({
    String? feeId,
    String? gymId,
    String? memberId,
    double? amount,
    double? paidAmount,
    double? dueAmount,
    DateTime? feeDate,
    DateTime? dueDate,
    String? paymentMode,
    String? remarks,
    bool? isPaid,
    bool? isActive,
    int? version,
  }) {
    return FeeModel(
      feeId: feeId ?? this.feeId,
      gymId: gymId ?? this.gymId,
      memberId: memberId ?? this.memberId,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      feeDate: feeDate ?? this.feeDate,
      dueDate: dueDate ?? this.dueDate,
      paymentMode: paymentMode ?? this.paymentMode,
      remarks: remarks ?? this.remarks,
      isPaid: isPaid ?? this.isPaid,
      isActive: isActive ?? this.isActive,
      version: version ?? this.version,
    );
  }
}