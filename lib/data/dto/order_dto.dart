class OrderDto {
  final Map<String, dynamic> products;
  final int totalPrice;
  final String status;
  final DateTime date;
  final String orderId;

  OrderDto({
    required this.products,
    required this.totalPrice,
    this.status = 'Доставлен',
    required this.date,
    this.orderId = '',
  });

  factory OrderDto.fromMap(Map<String, dynamic> map) {
    return OrderDto(
      products: map['products'],
      totalPrice: map['totalPrice'],
      status: map['status'],
      date: map['date'].toDate(),
      orderId: map['orderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products,
      'totalPrice': totalPrice,
      'status': status,
      //convert DateTime to Timestamp
      'date': date.toUtc(),
      'orderId': orderId,
    };
  }
}