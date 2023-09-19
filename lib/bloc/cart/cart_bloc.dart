import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/data/model/payment_model.dart';
import 'package:mobile8_final_project/data/model/user_model.dart';
import 'package:mobile8_final_project/data/repositories/cart_repository.dart';
import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';
import '../../data/repositories/orders_repository.dart';
import '../../data/repositories/payment_repository.dart';
import '../../data/repositories/user_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

//Класс CartBloc наследуется от Bloc<CartEvent, CartState>
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;
  final UserRepository _userRepository;
  final PaymentRepository _paymentRepository;
  final OrdersRepository _orderRepository;

  //Конструктор принимает экземпляр CartRepository и UserRepository
  CartBloc(this._cartRepository, this._userRepository, this._paymentRepository, this._orderRepository) : super(const LoadingCartState()) {
    //при получении события LoadCartEvent вызывается метод _onLoadEvent
    on<LoadCartEvent>(_onLoadEvent);
    //при получении события AddProductToCart вызывается метод _onAddEvent
    on<AddProductToCart>(_onAddEvent);
    //при получении события RemoveProductFromCart вызывается метод _onRemoveEvent
    on<RemoveProductFromCart>(_onRemoveEvent);
    //при получении события PayEvent вызывается метод _onPayEvent
    on<PayEvent>(_onPayEvent);

    //on<UpdateCartEvent>(_onUpdateEvent);
    //добавляем событие LoadCartEvent
    add(const LoadCartEvent());
  }

  //метод который вызывается при событии LoadCartEvent
  Future<void> _onLoadEvent(LoadCartEvent event, Emitter<CartState> emit) async {
    //перед загрузкой корзины выводим состояние загрузки
    try {
      //загружаем корзину
      Cart cart = await _cartRepository.getCart();
      //загружаем товары в наличии, чтобы проверять, можно ли добавлять товар в корзину
      Map<String, int> stock = await _cartRepository.getProductsInStock(cart.products);
      //загружаем пользователя, чтобы получить его адрес для отображения сверху экрана
      User user = await _userRepository.getUser();

      //здесь вариант с использованием стрима
      // await emit.forEach(_cartRepository.getCartStream(), onData: (cart) {
      //   //выводим состояние с загруженной корзиной, когда получены изменившиеся данные (а также при первой загрузке)
      //   return LoadedCartState(cart: cart, address: user.address, stock: stock);
      // }, onError: (error, stackTrace) {
      //   //выводим ошибку, если она возникла
      //   return ErrorCartState();
      // });

      emit(LoadedCartState(cart: cart, stock: stock, address: user.address));
    } catch (error) {
      print('Ошибка при загрузке корзины: $error');
      emit(ErrorCartState());
    }
  }


  //метод который вызывается при событии AddProductToCart
  Future<void> _onAddEvent(AddProductToCart event, Emitter<CartState> emit) async {
    //показываем на экране новую корзину
    Cart cart = Cart(products: [
      for (var item in event.state.cart.products)
        if (item.id == event.product.id)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity + 1, image: item.image, category: item.category, description: item.description)
        else
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity, image: item.image, category: item.category, description: item.description)
    ], totalPrice: event.state.cart.totalPrice + event.product.price);
    emit(LoadedCartState(cart: cart, stock: event.state.stock, address: event.state.address));
    try {
      //добавляем товар в корзину
      await _cartRepository.addProductToCart(event.product);
    } catch (error) {
      emit(ErrorCartState());
    }
  }

  //метод который вызывается при событии RemoveProductFromCart
  Future<void> _onRemoveEvent(RemoveProductFromCart event, Emitter<CartState> emit) async {
    //показываем на экране новую корзину
    Cart cart = Cart(products: [
      for (var item in event.state.cart.products)
        if (item.id == event.product.id && item.quantity > 1)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity - 1, image: item.image, category: item.category, description: item.description)
        else if (item.id != event.product.id && item.quantity > 0)
          Product(id: item.id, name: item.name, price: item.price, quantity: item.quantity, image: item.image, category: item.category, description: item.description)
    ], totalPrice: event.state.cart.totalPrice - event.product.price);
    emit(LoadedCartState(cart: cart, stock: event.state.stock, address: event.state.address));
    try {
      //удаляем товар из корзины
      await _cartRepository.removeProductFromCart(event.product.id);
    } catch (error) {
      emit(ErrorCartState());
    }
  }

  //метод который вызывается при событии PayEvent
  Future<void> _onPayEvent(PayEvent event, Emitter<CartState> emit) async {
    emit(PaymentLoadingCartState(cart: event.cart, stock: event.stock, address: event.address));
    try {
      //получаем результат оплаты
      var result = await _paymentRepository.pay(Payment(price: event.cart.totalPrice));
      if (result == 'success') {
        //если оплата прошла успешно, то добавляем заказ и очищаем корзину
        await _orderRepository.addOrder();
        _cartRepository.notify();
      } else {
        emit(PaymentErrorCartState());
      }
      add(LoadCartEvent());
    } catch (error) {
      emit(PaymentErrorCartState());
    }
  }
}
