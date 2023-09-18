import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/bloc/products_in_category/products_in_category_event.dart';
import 'package:mobile8_final_project/bloc/products_in_category/products_in_category_state.dart';
import 'package:mobile8_final_project/data/model/cart_model.dart';
import 'package:mobile8_final_project/data/repositories/cart_repository.dart';
import 'package:mobile8_final_project/data/repositories/products_repository.dart';

import '../../data/model/product_model.dart';

class ProductsInCategoryBloc extends Bloc<ProductsInCategoryEvent, ProductsInCategoryState> {
  final ProductsRepository _productsRepository;
  final String _categoryId;
  final CartRepository _cartRepository;

  ProductsInCategoryBloc(this._productsRepository, this._categoryId, this._cartRepository) : super(const LoadingProductsInCategoryState()) {
    on<LoadProductsInCategoryEvent>(_onLoadEvent);
    on<AddProductToCart>(_onAddEvent);
    on<RemoveProductFromCart>(_onRemoveEvent);
    add(LoadProductsInCategoryEvent(_categoryId));
  }

  Future<void> _onLoadEvent(LoadProductsInCategoryEvent event, Emitter<ProductsInCategoryState> emit) async {
    try {
      List<Product> products = await _productsRepository.getProductsByCategory(_categoryId);
      Cart cart = await _cartRepository.getCart();
      Map<String, int> stock = await _cartRepository.getProductsInStock(cart.products);
      emit(LoadedProductsInCategoryState(products: products, cart: cart, stock: stock, categoryId: _categoryId));
    } catch (error) {
      print('Ошибка при загрузке товаров в категории: $error');
      emit(ErrorProductsInCategoryState());
    }
  }

  // Future<void> _onUpdateEvent(UpdateProductsInCategoryEvent event, Emitter<ProductsInCategoryState> emit) async {
  //   try {
  //     Cart cart = await _cartRepository.getCart();
  //     Map<String, int> stock = await _cartRepository.getProductsInStock(cart.products);
  //     emit(LoadedProductsInCategoryState(products: event.products, cart: event.cart, stock: stock, categoryId: event.categoryId));
  //   } catch (error) {
  //     print('Ошибка при загрузке товаров в категории: $error');
  //     emit(ErrorProductsInCategoryState());
  //   }
  // }

Future<void> _onAddEvent(AddProductToCart event, Emitter<ProductsInCategoryState> emit) async {
    //показываем на экране новую корзину
    Cart cart = Cart(products: [
      for (var item in event.state.cart.products)
        if (item.id == event.product.id)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity + 1, image: item.image, category: item.category, description: item.description)
        else
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity, image: item.image, category: item.category, description: item.description)
    ], totalPrice: event.state.cart.totalPrice + event.product.price);
    emit(LoadedProductsInCategoryState(cart: cart, stock: event.state.stock, categoryId: event.state.categoryId, products: event.state.products));
    try {
      //добавляем товар в корзину
      await _cartRepository.addProductToCart(event.product);
    } catch (error) {
      emit(ErrorProductsInCategoryState());
    }
  }

  Future<void> _onRemoveEvent(RemoveProductFromCart event, Emitter<ProductsInCategoryState> emit) async {
    //показываем на экране новую корзину
    Cart cart = Cart(products: [
      for (var item in event.state.cart.products)
        if (item.id == event.product.id && item.quantity > 1)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity - 1, image: item.image, category: item.category, description: item.description)
        else if (item.quantity > 1)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity, image: item.image, category: item.category, description: item.description)
    ], totalPrice: event.state.cart.totalPrice - event.product.price);
    emit(LoadedProductsInCategoryState(cart: cart, stock: event.state.stock, categoryId: event.state.categoryId, products: event.state.products));
    try {
      //удаляем товар из корзины
      await _cartRepository.removeProductFromCart(event.product.id);
    } catch (error) {
      emit(ErrorProductsInCategoryState());
    }
  }
}