class CartDto {
  final Map<String, dynamic> products;
  final int totalPrice;

  CartDto({
    required this.products,
    required this.totalPrice,
  });

  factory CartDto.fromMap(Map<String, dynamic> map) {
    return CartDto(
      products: map['products'],
      totalPrice: map['totalPrice'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products,
      'totalPrice': totalPrice,
    };
  }
}