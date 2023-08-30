import 'package:mobile8_final_project/data/datasource/orders_remote_datasource.dart';

import '../model/order_model.dart';
import '../model/product_model.dart';

class OrdersRepository {
  final OrdersRemoteDatasource _ordersRemoteDatasource;

  OrdersRepository(this._ordersRemoteDatasource);

  Future<List<Order>> getOrders() async {
    try {
      final List<Order> orders = [];
      final ordersDto = await _ordersRemoteDatasource.getOrders();
      for (var orderDto in ordersDto) {
        orders.add(Order(
          products: [
            for (var product in orderDto.products.entries)
              Product(
                id: product.key,
                name: product.value['name'] as String,
                price: product.value['price'] as int,
                quantity: product.value['quantity'] as int,
                image: product.value['image'] as String,
                category: product.value['category'] as String,
                description: product.value['description'] as String,
              )
          ],
          totalPrice: orderDto.totalPrice,
          status: orderDto.status,
          date: orderDto.date,
          orderId: orderDto.orderId,
        ));
      }
      return orders;
    } catch (e) {
      print('Ошибка при получении заказов: $e');
      rethrow;
    }
  }

  Future<void> addOrder() async {
    try {
      await _ordersRemoteDatasource.addOrder();
    } catch (e) {
      print('Ошибка при добавлении заказа: $e');
    }
  }
}
