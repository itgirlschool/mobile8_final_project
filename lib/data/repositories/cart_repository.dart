import 'package:flutter/cupertino.dart';
import 'package:mobile8_final_project/data/datasource/cart_remote_datasource.dart';
import 'package:mobile8_final_project/data/dto/cart_dto.dart';

import '../dto/product_dto.dart';
import '../model/cart_model.dart';
import '../model/product_model.dart';

class CartRepository extends ChangeNotifier{
  final CartRemoteDatasource _cartRemoteDatasource;

  CartRepository(this._cartRemoteDatasource);

  Future<void> addProductToCart(Product product) async {
    try {
      await _cartRemoteDatasource.addProductToCart(ProductDto(
        id: product.id,
        name: product.name,
        price: product.price,
        quantity: product.quantity,
        image: product.image,
        category: product.category,
        description: product.description,
      ));
      notifyListeners();
    } catch (e) {
      print('Ошибка при добавлении товара в корзину: $e');
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    try {
      await _cartRemoteDatasource.removeProductFromCart(productId);
      notifyListeners();
    } catch (e) {
      print('Ошибка при удалении товара из корзины: $e');
    }
  }

  Future<void> removeAllProductsFromCart() async {
    try {
      await _cartRemoteDatasource.clearCart();
      notifyListeners();
    } catch (e) {
      print('Ошибка при удалении всех товаров из корзины: $e');
    }
  }

  Future<Cart> getCart() async {
    try {
      final CartDto cartDto = await _cartRemoteDatasource.getCart();
      return Cart(
        products: [
          for (var item in cartDto.products.entries)
            Product(
              id: item.key,
              name: item.value['name'] as String,
              price: item.value['price'] as int,
              quantity: item.value['quantity'] as int,
              image: item.value['image'] as String,
              category: item.value['category'] as String,
              description: item.value['description'] as String,
            ),
        ],
        totalPrice: cartDto.totalPrice,
      );
    } catch (e) {
      print('Ошибка при получении корзины: $e');
      rethrow;
    }
  }

  Stream<Cart> getCartStream() {
    try {
      return _cartRemoteDatasource.getCartStream().map((cartDto) => Cart(
        products: [
          for (var item in cartDto.products.entries)
            Product(
              id: item.key,
              name: item.value['name'] as String,
              price: item.value['price'] as int,
              quantity: item.value['quantity'] as int,
              image: item.value['image'] as String,
              category: item.value['category'] as String,
              description: item.value['description'] as String,
            ),
        ],
        totalPrice: cartDto.totalPrice,
      ));
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, int>> getProductsInStock(List<Product> products) {
    try {
      return _cartRemoteDatasource.getProductsInStock(
        products.map((e) => e.id).toList(),
      );
    } catch (e) {
      print('Ошибка при получении товаров в наличии: $e');
      rethrow;
    }
  }
}
