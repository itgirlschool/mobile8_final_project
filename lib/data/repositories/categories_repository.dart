import 'package:mobile8_final_project/data/datasource/categories_remote_datasource.dart';

import '../model/category_model.dart';

class CategoriesRepository {
  final CategoriesRemoteDatasource _categoriesRemoteDatasource;

  CategoriesRepository(this._categoriesRemoteDatasource);

  Future<List<Category>> getCategories() async {
    try {
      final List<Category> categories = [];
      final categoriesDto = await _categoriesRemoteDatasource.getCategories();
      for (var categoryDto in categoriesDto) {
        categories.add(Category(
          id: categoryDto.id as String,
          name: categoryDto.name,
          image: categoryDto.image,
        ));
      }
      return categories;
    } catch (e) {
      print('Ошибка при получении категорий: $e');
      rethrow;
    }

  }
}