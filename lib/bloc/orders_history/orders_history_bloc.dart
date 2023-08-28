import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/data/repositories/orders_repository.dart';
import '../../data/model/order_model.dart';
import 'orders_history_event.dart';
import 'orders_history_state.dart';

class OrdersHistoryBloc extends Bloc<OrdersHistoryEvent, OrdersHistoryState> {
  final OrdersRepository _repository;

  OrdersHistoryBloc(this._repository) : super(const LoadingOrdersHistoryState()) {
    on<LoadOrdersHistoryEvent>(_onLoadEvent);
    add(LoadOrdersHistoryEvent());
  }

  Future<void> _onLoadEvent(LoadOrdersHistoryEvent event, Emitter<OrdersHistoryState> emit) async {
    emit(const LoadingOrdersHistoryState());
    try {
      List<Order> orders = await _repository.getOrders();
      emit(LoadedOrdersHistoryState(orders: orders));
    } catch (error, stackTrace) {
    emit(ErrorOrdersHistoryState());
    }
  }
}