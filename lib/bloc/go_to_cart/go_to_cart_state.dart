import '../../data/model/cart_model.dart';

sealed class GoToCartState {
  const GoToCartState();
}

class LoadingGoToCartState extends GoToCartState {
  const LoadingGoToCartState();
}

class LoadedGoToCartState extends GoToCartState {
  final Cart cart;

  const LoadedGoToCartState({required this.cart});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedGoToCartState &&
          runtimeType == other.runtimeType &&
          cart == other.cart;

  @override
  int get hashCode => cart.hashCode;
}

class ErrorGoToCartState extends GoToCartState {}