import 'package:mobile8_final_project/data/model/product_model.dart';

// Абстрактный класс CartEvent
class CartEvent {
  const CartEvent();
}

// Событие загрузки корзины
class LoadCartEvent extends CartEvent {}

// Событие добавления товара в корзину
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

// Событие удаления товара из корзины
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
