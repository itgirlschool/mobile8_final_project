import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/categories_repository.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository _repository;

  // Конструктор
  CategoriesBloc(this._repository) : super(const LoadingCategoriesState()) {
    // При получении события загрузки заказов вызываем метод загрузки
    on<LoadCategoriesEvent>(_onLoadEvent);
    // добавляем событие загрузки заказов
    add(LoadCategoriesEvent());
  }

  Future _onLoadEvent(LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
    emit(const LoadingCategoriesState());
    try {
      final categories = await _repository.getCategories();
      emit(LoadedCategoriesState(categories: categories));
    } catch (error, stackTrace) {
      emit(ErrorCategoriesState());
    }
  }

}