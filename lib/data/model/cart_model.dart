import 'package:mobile8_final_project/data/model/product_model.dart';

class Cart {
  final List<Product> products;
  final int totalPrice;

  Cart({required this.products, required this.totalPrice});
}
