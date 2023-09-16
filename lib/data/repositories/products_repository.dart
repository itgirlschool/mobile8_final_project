import 'package:mobile8_final_project/data/datasource/products_remote_datasource.dart';

import '../model/product_model.dart';

class ProductsRepository {
  final ProductsRemoteDatasource _productsRemoteDatasource;

  ProductsRepository(this._productsRemoteDatasource);

  Future<List<Product>> getProductsByCategory(String categoryId) async {
    try {
      final List<Product> products = [];
      final productsDto = await _productsRemoteDatasource.getByCategoryId(categoryId);
      for (var productDto in productsDto) {
        products.add(Product(
          id: productDto.id,
          name: productDto.name,
          price: productDto.price,
          image: productDto.image,
          category: productDto.category,
          description: productDto.description,
          quantity: productDto.quantity,
        ));
      }
      return products;
    } catch (e) {
      print('Ошибка при получении продуктов: $e');
      rethrow;
    }
  }

  Future<Product> getByCategory(String productId) async{
    try {
      final productDto = await _productsRemoteDatasource.getById(productId);
      return Product(
        id: productDto.id,
        name: productDto.name,
        price: productDto.price,
        image: productDto.image,
        category: productDto.category,
        description: productDto.description,
        quantity: productDto.quantity,
      );
    } catch (e) {
      print('Ошибка при получении продукта: $e');
      rethrow;
    }

  }
}
