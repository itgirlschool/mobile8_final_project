import 'package:mobile8_final_project/bloc/products_in_category/products_in_category_state.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';

class ProductsInCategoryEvent {
  const ProductsInCategoryEvent();
}

class LoadProductsInCategoryEvent extends ProductsInCategoryEvent {
  final String categoryId;
  LoadProductsInCategoryEvent(this.categoryId);
}

class UpdateProductsInCategoryEvent extends ProductsInCategoryEvent {
  final Cart cart;
  final int categoryId;
  final Map<String, int> stock;
  final List<Product> products;
  UpdateProductsInCategoryEvent({required this.cart, required this.categoryId, required this.stock, required this.products});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateProductsInCategoryEvent &&
          runtimeType == other.runtimeType &&
          cart == other.cart;

  @override
  int get hashCode => cart.hashCode;
}

// Событие добавления товара в корзину
class AddProductToCart extends ProductsInCategoryEvent {
  final Product product;

  LoadedProductsInCategoryState state;

  AddProductToCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddProductToCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

// Событие удаления товара из корзины
class RemoveProductFromCart extends ProductsInCategoryEvent {
  final Product product;

  LoadedProductsInCategoryState state;

  RemoveProductFromCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is RemoveProductFromCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}