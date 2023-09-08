import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile8_final_project/data/datasource/cart_remote_datasource.dart';

import '../dto/order_dto.dart';

class OrdersRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addOrder() {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    //String userId = '4';
    CartRemoteDatasource cartRemoteDatasource = CartRemoteDatasource();

    return cartRemoteDatasource.getCart().then((cart) async {
      var order = OrderDto(
        products: cart.products,
        totalPrice: cart.totalPrice,
        date: DateTime.now(),
      ).toMap();
      try {
        CollectionReference ordersCollection = firestore.collection('orders');
        await ordersCollection.doc(userId).collection('userOrders').add(
              order,
            );
        //TODO: раскомментить, когда не нужны будут тестовые данные корзины
        await cartRemoteDatasource.clearCart();
      } catch (e) {
        print('Ошибка при добавлении заказа: $e');
      }
    });
  }

  Future<List<OrderDto>> getOrders() async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;

    //String userId = '4';
    try {
      CollectionReference ordersCollection = firestore.collection('orders');
      QuerySnapshot ordersSnapshot = await ordersCollection.doc(userId).collection('userOrders').get();
      List<OrderDto> orders = [];
      for (var order in ordersSnapshot.docs) {
        var orderData = order.data() as Map<String, dynamic>;
        orderData['orderId'] = order.id;
        orders.add(OrderDto.fromMap(orderData));
      }
      return orders;
    } catch (e) {
      print('Ошибка при получении заказов: $e');
     rethrow;
    }
  }

  Future<OrderDto> getOrderById(String orderId) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    try {
      CollectionReference ordersCollection = firestore.collection('orders');
      DocumentSnapshot orderSnapshot = await ordersCollection.doc(userId).collection('userOrders').doc(orderId).get();
      var orderData = orderSnapshot.data() as Map<String, dynamic>;
      orderData['orderId'] = orderSnapshot.id;
      return OrderDto.fromMap(orderData);
    } catch (e) {
      print('Ошибка при получении заказа: $e');
      rethrow;
    }
  }
}
