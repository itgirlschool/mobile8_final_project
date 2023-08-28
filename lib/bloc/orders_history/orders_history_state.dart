import '../../data/model/order_model.dart';

//Родительский класс для состояний экрана
//sealed class позволяет нам ограничить набор возможных состояний, типа как enum
sealed class OrdersHistoryState {
  const OrdersHistoryState();
}

// Начальное состояние экрана
class LoadingOrdersHistoryState extends OrdersHistoryState {
  const LoadingOrdersHistoryState();
}

//Состояние экрана с уже загруженными данными

class LoadedOrdersHistoryState extends OrdersHistoryState {
  final List<Order> orders;

  const LoadedOrdersHistoryState({required this.orders});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedOrdersHistoryState &&
          runtimeType == other.runtimeType &&
          orders == other.orders;

  @override
  int get hashCode => orders.hashCode;
}

//Состояние экрана с ошибкой
class ErrorOrdersHistoryState extends OrdersHistoryState {}