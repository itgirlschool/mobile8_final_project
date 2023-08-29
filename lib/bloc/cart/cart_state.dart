import '../../data/model/cart_model.dart';

//Родительский класс для состояний экрана
//sealed class позволяет нам ограничить набор возможных состояний, как enum
sealed class CartState {
  const CartState();
}

// Начальное состояние экрана
class LoadingCartState extends CartState {
  const LoadingCartState();
}

// Состояние экрана с уже загруженными данными
class LoadedCartState extends CartState {
  final Cart cart;
  final Map<String, int> stock;
  final String address;

  const LoadedCartState({required this.cart, required this.stock, required this.address});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedCartState && runtimeType == other.runtimeType && cart == other.cart;

  @override
  int get hashCode => cart.hashCode;
}

// Состояние экрана с ошибкой
class ErrorCartState extends CartState {}