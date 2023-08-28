import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/data/repositories/orders_repository.dart';
import '../../data/model/order_model.dart';
import 'orders_history_event.dart';
import 'orders_history_state.dart';

// Блок для экрана истории заказов
class OrdersHistoryBloc extends Bloc<OrdersHistoryEvent, OrdersHistoryState> {
  final OrdersRepository _repository;

  // Конструктор
  OrdersHistoryBloc(this._repository) : super(const LoadingOrdersHistoryState()) {
    // При получении события загрузки заказов вызываем метод загрузки
    on<LoadOrdersHistoryEvent>(_onLoadEvent);
    // добавляем событие загрузки заказов
    add(LoadOrdersHistoryEvent());
  }

  // Метод загрузки заказов
  Future<void> _onLoadEvent(LoadOrdersHistoryEvent event, Emitter<OrdersHistoryState> emit) async {
    // Перед загрузкой заказов выводим состояние загрузки
    emit(const LoadingOrdersHistoryState());
    try {
      // Загружаем заказы
      List<Order> orders = await _repository.getOrders();
      // Выводим состояние с загруженными заказами
      emit(LoadedOrdersHistoryState(orders: orders));
    } catch (error, stackTrace) {
      // Выводим состояние с ошибкой
      emit(ErrorOrdersHistoryState());
    }
  }
}
