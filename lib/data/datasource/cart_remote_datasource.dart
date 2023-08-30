import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../dto/cart_dto.dart';
import '../dto/product_dto.dart';

class CartRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProductToCart(ProductDto productDto) async {
    //TODO раскомментить, когда не нужны будут тестовые данные
    //User user = FirebaseAuth.instance.currentUser!;
    //String userId = user.uid;
    String userId = '4';

    var product = productDto.toMap();
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
            'quantity': 1,
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
              'quantity': 1,
              'image': product['image'],
              'category': product['category'],
              'description': product['description'],
            },
          },
          'totalPrice': product['price'],
        });
      }
    } catch (e) {
      throw Exception('addProductToCart error');
    }
  }

  Future<void> removeProductFromCart(String productId) async {
    //TODO раскомментить, когда не нужны будут тестовые данные
    //User user = FirebaseAuth.instance.currentUser!;
    //String userId = user.uid;
    String userId = '4';

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
            // Если количество товара больше 1, уменьшаем количество на 1
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
            // Если количество товара равно 1, удаляем его из корзины
            // Если товар не тот, который нужно удалить, добавляем его в новую корзину
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
    } catch (e) {
      throw Exception('removeProductFromCart error');
    }
  }

  Future<void> clearCart() async {
    //TODO раскомментить, когда не нужны будут тестовые данные
    //User user = FirebaseAuth.instance.currentUser!;
    //String userId = user.uid;

    String userId = '4';

    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        await cartReference.delete();
      }
    } catch (e) {
      throw Exception('clearCart error');
    }
  }

  Future<CartDto> getCart() async {
    //TODO раскомментить, когда не нужны будут тестовые данные
    //User user = FirebaseAuth.instance.currentUser!;
    //String userId = user.uid;

    String userId = '4';

    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        var cart = cartSnapshot.data() as Map<String, dynamic>;
        return CartDto.fromMap(cart);
      } else {
        return CartDto(products: {}, totalPrice: 0);
      }
    } catch (e) {
      throw Exception('getCart error datasource');
    }
  }

  Stream<CartDto> getCartStream() {
    try {
      //TODO раскомментить, когда не нужны будут тестовые данные
      //User user = FirebaseAuth.instance.currentUser!;
      //String userId = user.uid;

      String userId = '4';

      DocumentReference cartReference = FirebaseFirestore.instance.collection('carts').doc(userId);

      Stream<DocumentSnapshot> stream = cartReference.snapshots();

      return stream.map((snapshot) {
        if (snapshot.exists) {
          var cart = snapshot.data() as Map<String, dynamic>;
          return CartDto.fromMap(cart);
        } else {
          return CartDto(products: {}, totalPrice: 0);
        }
      });
    } catch (e) {
      return const Stream.empty();
    }
  }


  Future<Map<String, int>> getProductsInStock(List<String> productIds) async {
    Map<String, int> productsInStock = {};
    try {
      if(productIds.isEmpty) return productsInStock;
      CollectionReference productsCollection = firestore.collection('products');
      for (var item in productIds) {
        DocumentSnapshot documentSnapshot = await productsCollection.doc(item).get();
        if(documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;
          productsInStock[item] = data['quantity'];
        }
      }
      return productsInStock;
    } catch (e) {
      throw Exception('Ошибка получения товаров в наличии: $e');
    }
  }
}
