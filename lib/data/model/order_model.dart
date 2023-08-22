import 'package:mobile8_final_project/data/model/product_model.dart';

class Order {
  final List<Product> products;
  final int totalPrice;
  final String status;
  final DateTime date;
  final String orderId;

  Order({
    required this.products,
    required this.totalPrice,
    this.status = 'Доставлен',
    required this.date,
    required this.orderId,
  });
}