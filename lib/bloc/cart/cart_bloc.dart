import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/data/model/user_model.dart';
import 'package:mobile8_final_project/data/repositories/cart_repository.dart';

import '../../data/model/cart_model.dart';
import '../../data/repositories/user_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;
  final UserRepository _userRepository;

CartBloc(this._repository, this._userRepository) : super(const LoadingCartState()) {
    on<LoadCartEvent>(_onLoadEvent);
    on<AddProductToCart>(_onAddEvent);
    on<RemoveProductFromCart>(_onRemoveEvent);
    add(LoadCartEvent());
  }

  Future<void> _onLoadEvent(LoadCartEvent event, Emitter<CartState> emit) async {
    emit(const LoadingCartState());
    try {
      Cart cart = await _repository.getCart();
      Map<String, int> stock =  await _repository.getProductsInStock(cart);
      User user = await _userRepository.getUser();
      await emit.forEach(_repository.getCartStream(), onData: (cart){
        return LoadedCartState(cart: cart, address: user.address, stock: stock);
      }, onError: (error, stackTrace) {
        return ErrorCartState();
      });
      //emit(LoadedCartState(cart: cart, stock: stock, address: user.address));
      
    } catch (error, stackTrace) {
      emit(ErrorCartState());
    }
  }

  Future<void> _onAddEvent(AddProductToCart event, Emitter<CartState> emit) async {
    try {
      await _repository.addProductToCart(event.product);
      //add(LoadCartEvent());
    } catch (error, stackTrace) {
      emit(ErrorCartState());
    }
  }

  Future<void> _onRemoveEvent(RemoveProductFromCart event, Emitter<CartState> emit) async {
    try {
      await _repository.removeProductFromCart(event.product.id);
      //add(LoadCartEvent());
    } catch (error, stackTrace) {
      emit(ErrorCartState());
    }
  }

}