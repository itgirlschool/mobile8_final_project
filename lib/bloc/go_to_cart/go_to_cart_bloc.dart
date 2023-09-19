import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/data/repositories/cart_repository.dart';

import '../../data/model/cart_model.dart';
import 'go_to_cart_event.dart';
import 'go_to_cart_state.dart';

class GoToCartBloc extends Bloc<GoToCartEvent, GoToCartState> {
  final CartRepository _cartRepository;

  GoToCartBloc(this._cartRepository) : super(const LoadingGoToCartState()) {
    on<LoadGoToCartEvent>(_onLoadEvent);
    _cartRepository.addListener(_update);
    add(LoadGoToCartEvent());
  }

  @override
  Future<void> close() {
    _cartRepository.removeListener(_update);
    return super.close();
  }

  void _update() {
    add(LoadGoToCartEvent());
  }

 Future<void> _onLoadEvent (LoadGoToCartEvent event, Emitter<GoToCartState> emit) async {
   try {
      Cart cart = await _cartRepository.getCart();
      emit(LoadedGoToCartState(cart: cart));

    }
    catch (error) {
      print('Ошибка при загрузке корзины: $error');
      emit(ErrorGoToCartState());
    }
  }

}