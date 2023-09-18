import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/bloc/product/product_event.dart';
import 'package:mobile8_final_project/bloc/product/product_state.dart';

import '../../data/repositories/cart_repository.dart';
import '../../data/repositories/products_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository productsRepository;
  final CartRepository cartRepository;
  final String productId;

  ProductBloc(this.productsRepository, this.cartRepository, this.productId) : super(const LoadingProductState()) {
    on<LoadProductEvent>(_onLoadEvent);
    on<AddProductToCart>(_onAddEvent);
    on<RemoveProductFromCart>(_onRemoveEvent);
    add(LoadProductEvent(productId));
  }

  Future<void> _onLoadEvent(LoadProductEvent event, Emitter<ProductState> emit) async {
    print('Загрузка товара');
    try {
      final product = await productsRepository.getById(productId);
      final stock = product.quantity;
      final cart = await cartRepository.getCart();
      print('Товар загружен');
      //get quantity of product in cart
      int quantityInCart =0;
      for (var i = 0; i < cart.products.length; i++) {
        if (cart.products[i].id == productId) {
          quantityInCart = cart.products[i].quantity;
          return;
        }
      }
      print('Количество товара в корзине: $quantityInCart');
      emit(LoadedProductState(product: product, stock: stock, inCart: quantityInCart ?? 0));
    } catch (error) {
      print('Ошибка при загрузке товара: $error');
      emit(ErrorProductState());
    }
  }

  Future<void> _onAddEvent(AddProductToCart event, Emitter<ProductState> emit) async {
    try {
      await cartRepository.addProductToCart(event.product);
      final stock = event.product.quantity;
      final quantityInCart = event.state.inCart + 1;
      emit(LoadedProductState(product: event.product, stock: stock, inCart: quantityInCart));
    } catch (error) {
      print('Ошибка при добавлении товара в корзину: $error');
      emit(ErrorProductState());
    }
  }

  Future<void> _onRemoveEvent(RemoveProductFromCart event, Emitter<ProductState> emit) async {
    try {
      await cartRepository.removeProductFromCart(event.product.id);
      final stock = event.product.quantity;
      final quantityInCart = event.state.inCart - 1;
      emit(LoadedProductState(product: event.product, stock: stock, inCart: quantityInCart));
    } catch (error) {
      print('Ошибка при удалении товара из корзины: $error');
      emit(ErrorProductState());
    }
  }
}
