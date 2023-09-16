import 'package:cloud_firestore/cloud_firestore.dart';

import '../dto/category_dto.dart';

class CategoriesRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<CategoryDto>> getCategories() async {
    try {
      CollectionReference categoriesCollection = firestore.collection('categories');
      QuerySnapshot categoriesSnapshot = await categoriesCollection.get();
      List<CategoryDto> categories = [];
      for (var category in categoriesSnapshot.docs) {
        var categoryData = category.data() as Map<String, dynamic>;
        categoryData['categoryId'] = category.id;
        categories.add(CategoryDto.fromMap(categoryData));
      }
      return categories;
    } catch (e) {
      print('Ошибка при получении категорий: $e');
      rethrow;
    }
}
}