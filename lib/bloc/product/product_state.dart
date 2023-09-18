import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';

sealed class ProductState {
  const ProductState();
}

class LoadingProductState extends ProductState {
  const LoadingProductState();
}

class LoadedProductState extends ProductState {
  final Product product;
  final int stock;
  final int inCart;

  const LoadedProductState({
    required this.product,
    required this.stock,
    required this.inCart,
  });

  @override
  bool operator ==(Object other) => identical(this, other) || other is LoadedProductState && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

class ErrorProductState extends ProductState {}
