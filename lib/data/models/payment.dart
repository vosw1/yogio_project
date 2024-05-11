class Payment {
  final int paymentId;
  final int reservationId;
  final int amount;
  final String way;
  final String state;
  final DateTime createdAt;

  Payment({
    required this.paymentId,
    required this.reservationId,
    required this.amount,
    required this.way,
    required this.state,
    required this.createdAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: json['id'],
      reservationId: json['reservationId'],
      amount: json['amount'],
      way: json['way'],
      state: json['state'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentId': paymentId,
      'reservationId': reservationId,
      'amount': amount,
      'way': way,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
