import 'package:cloud_firestore/cloud_firestore.dart';

import '../dto/product_dto.dart';

class ProductsRemoteDatasource {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductDto>> getByCategoryId(String categoryId) async {
    int catId = int.parse(categoryId);
    try {
      CollectionReference productsCollection = _firestore.collection('products');
      QuerySnapshot productsSnapshot = await productsCollection.where('category', isEqualTo: catId).get();
      List<ProductDto> products = [];
      for (var product in productsSnapshot.docs) {
        var productData = product.data() as Map<String, dynamic>;
        productData['id'] = product.id;
        products.add(ProductDto.fromMap(productData));
      }
      return products;
    } catch (e) {
      print('Ошибка при получении продуктов: $e');
      rethrow;
    }
  }

  Future<ProductDto> getById(String productId) async {
    try {
      CollectionReference productsCollection = _firestore.collection('products');
      DocumentSnapshot productSnapshot = await productsCollection.doc(productId).get();
      var productData = productSnapshot.data() as Map<String, dynamic>;
      productData['id'] = productSnapshot.id;
      return ProductDto.fromMap(productData);
    } catch (e) {
      print('Ошибка при получении продукта: $e');
      rethrow;
    }
  }
}
