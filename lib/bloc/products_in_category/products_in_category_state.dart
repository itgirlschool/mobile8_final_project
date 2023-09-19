import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';

sealed class ProductsInCategoryState {
  const ProductsInCategoryState();
}

class LoadingProductsInCategoryState extends ProductsInCategoryState {
  const LoadingProductsInCategoryState();
}

class LoadedProductsInCategoryState extends ProductsInCategoryState {
  final List<Product> products;
  //final String categoryId;
  final Map<String, int> stock;
  final Cart cart;

  const LoadedProductsInCategoryState({required this.products, required this.stock, required this.cart, });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedProductsInCategoryState &&
          runtimeType == other.runtimeType &&
          cart == other.cart;

  @override
  int get hashCode => products.hashCode;
}

class ErrorProductsInCategoryState extends ProductsInCategoryState {}