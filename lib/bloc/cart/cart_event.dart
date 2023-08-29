import 'package:mobile8_final_project/data/model/cart_model.dart';
import 'package:mobile8_final_project/data/model/product_model.dart';

class CartEvent {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {}

class AddProductToCart extends CartEvent{
  final Product product;

  const AddProductToCart({required this.product});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AddProductToCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

class RemoveProductFromCart extends CartEvent {
  final Product product;

  const RemoveProductFromCart({required this.product});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RemoveProductFromCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}
