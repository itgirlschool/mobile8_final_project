import 'package:cloud_firestore/cloud_firestore.dart';

import '../dto/cart_dto.dart';

class CartRemoteDatasource {
  //CollectionReference carts = FirebaseFirestore.instance.collection('carts');
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //TODO: Переделать на получение id пользователя
  String userId = '4';

  Future<void> addProductToCart(Map<String, dynamic> product) async {
    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();

      // Проверяем, существует ли уже корзина для данного пользователя
      if (cartSnapshot.exists) {
        var cart = cartSnapshot.data() as Map<String, dynamic>;
        int totalPrice = 0;
        // Создаем новую корзину
        Map<String, dynamic> newCart = {'products': {}, 'totalPrice': ''};
        bool isProductExist = false;
        // Перебираем все товары в корзине и считаем общую стоимость
        for (var item in cart['products'].entries) {
          var price = item.value['price'] as int;
          var quantity = item.value['quantity'] as int;
          totalPrice += price * quantity;
          newCart['products'][item.key] = {
            'name': item.value['name'],
            'price': item.value['price'],
            'quantity': item.value['quantity'],
            'image': item.value['image'],
            'category': item.value['category'],
            'description': item.value['description'],
          };
          // Проверяем, есть ли уже такой товар в корзине
          if (item.key == product['id']) {
            totalPrice += price;
            isProductExist = true;
            newCart['products'][item.key]['quantity'] += 1;
          }
        }
        // Если товара нет в корзине, добавляем его
        if (!isProductExist) {
          totalPrice += product['price'] as int;
          newCart['products'][product['id']] = {
            'name': product['name'],
            'price': product['price'],
            'quantity': product['quantity'],
            'image': product['image'],
            'category': product['category'],
            'description': product['description'],
          };
        }
        newCart['totalPrice'] = totalPrice;
        // Обновляем корзину
        await cartReference.update(
          newCart,
        );
      } else {
        // Если корзины нет, создаем ее и добавляем новый товар
        await cartReference.set({
          'products': {
            product['id']: {
              'name': product['name'],
              'price': product['price'],
              'quantity': product['quantity'],
              'image': product['image'],
              'category': product['category'],
              'description': product['description'],
            },
          }
        });
      }
      //print('Товар успешно добавлен в корзину!');
    } catch (e) {
      // print('Ошибка при добавлении товара в корзину: $e');
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        var cart = cartSnapshot.data() as Map<String, dynamic>;
        int totalPrice = 0;
        Map<String, dynamic> newCart = {'products': {}, 'totalPrice': ''};
        for (var item in cart['products'].entries) {
          var price = item.value['price'] as int;
          var quantity = item.value['quantity'] as int;
          if (item.key == productId && quantity > 1) {
            print('Удаляем товар из корзины');
            totalPrice += price * (quantity - 1);
            newCart['products'][item.key] = {
              'name': item.value['name'],
              'price': item.value['price'],
              'quantity': item.value['quantity'] - 1,
              'image': item.value['image'],
              'category': item.value['category'],
              'description': item.value['description'],
            };
          } else if (item.key != productId) {
            totalPrice += price * quantity;
            newCart['products'][item.key] = {
              'name': item.value['name'],
              'price': item.value['price'],
              'quantity': item.value['quantity'],
              'image': item.value['image'],
              'category': item.value['category'],
              'description': item.value['description'],
            };
          }
        }
        newCart['totalPrice'] = totalPrice;
        await cartReference.update(
          newCart,
        );
      }
      //print('Товар успешно удален из корзины!');
    } catch (e) {
      //print('Ошибка при удалении товара из корзины: $e');
    }
  }

  Future<void> removeAllProductsFromCart() async {
    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        await cartReference.delete();
      }
      //print('Товар успешно удален из корзины!');
    } catch (e) {
      //print('Ошибка при удалении товара из корзины: $e');
    }
  }

  Future<CartDto> getCart() async {
    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        var cart = cartSnapshot.data() as Map<String, dynamic>;
        return CartDto.fromMap(cart);
      } else {
        throw Exception('empty cart');
        //return CartDto();
      }
    } catch (e) {
      //print('Ошибка при получении корзины: $e');
      //return CartDto();
      rethrow;
    }
  }

}
