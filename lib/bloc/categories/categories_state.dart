import '../../data/model/category_model.dart';

sealed class CategoriesState {
  const CategoriesState();
}

class LoadingCategoriesState extends CategoriesState {
  const LoadingCategoriesState();
}

class LoadedCategoriesState extends CategoriesState {
  final List<Category> categories;

  const LoadedCategoriesState({required this.categories});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedCategoriesState &&
          runtimeType == other.runtimeType &&
          categories == other.categories;

  @override
  int get hashCode => categories.hashCode;
}

class ErrorCategoriesState extends CategoriesState {}