import 'package:mobile8_final_project/bloc/cart/cart_state.dart';
import 'package:mobile8_final_project/data/model/product_model.dart';

import '../../data/model/cart_model.dart';

// Абстрактный класс CartEvent
class CartEvent {
  const CartEvent();
}

// Событие загрузки корзины
class LoadCartEvent extends CartEvent {
  const LoadCartEvent();
}

class UpdateCartEvent extends CartEvent {
  final Cart cart;
  final Map<String, int> stock;
  final String address;

  const UpdateCartEvent({required this.cart, required this.stock, required this.address});

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCartEvent && runtimeType == other.runtimeType && cart == other.cart;

  @override
  int get hashCode => cart.hashCode;
}

// Событие добавления товара в корзину
class AddProductToCart extends CartEvent {
  final Product product;

  LoadedCartState state;

  AddProductToCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddProductToCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

// Событие удаления товара из корзины
class RemoveProductFromCart extends CartEvent {
  final Product product;

  LoadedCartState state;

  RemoveProductFromCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is RemoveProductFromCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

class PayEvent extends CartEvent {
  final Cart cart;
  final String address;
  final Map<String, int> stock;

  const PayEvent({ required this.address, required this.stock, required this.cart});

  @override
  bool operator ==(Object other) => identical(this, other) || other is PayEvent && runtimeType == other.runtimeType && cart == other.cart;

  @override
  int get hashCode => cart.hashCode;
}
