import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../dto/cart_dto.dart';
import '../dto/product_dto.dart';

class CartRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProductToCart(ProductDto productDto) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
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
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;

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
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;

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
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;

    try {
      DocumentReference cartReference = firestore.collection('carts').doc(userId);
      DocumentSnapshot cartSnapshot = await cartReference.get();
      if (cartSnapshot.exists) {
        var cart = cartSnapshot.data() as Map<String, dynamic>;
        return CartDto.fromMap(cart);
      } else {
        throw Exception('empty cart');
      }
    } catch (e) {
      throw Exception('getCart error');
    }
  }

  Future<Map<String, String>> getProductsInStock(CartDto cart) async {
    User user = FirebaseAuth.instance.currentUser!;
    String userId = user.uid;
    List<String> documentIds = [for (var item in cart.products.entries) item.key.toString()];
    Map<String, String> productsInStock = {};
    try {
      CollectionReference productsCollection = firestore.collection('products');

      QuerySnapshot querySnapshot = await productsCollection.where(FieldPath.documentId, whereIn: documentIds).get();
      List<DocumentSnapshot> documents = querySnapshot.docs;
      for (var document in documents) {
        var data = document.data() as Map<String, dynamic>;
        productsInStock[document.id] = data['quantity'].toString();
      }
      return productsInStock;
    } catch (e) {
      throw Exception('getCart error');
    }
  }
}
