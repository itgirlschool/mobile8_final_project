import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/bloc/profile/profile_event.dart';
import 'package:mobile8_final_project/bloc/profile/profile_state.dart';

import '../../data/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _profileRepository;

  //Конструктор принимает экземпляр UserRepository
  ProfileBloc(this._profileRepository) : super(const LoadingProfileState()) {
    //при получении события LoadProfileEvent вызывается метод _onLoadEvent
    on<LoadProfileEvent>(_onLoadEvent);
    //при получении события EditProfileEvent вызывается метод _onEditEvent
    on<EditProfileEvent>(_onEditEvent);
    //при получении события UpdateProfileEvent вызывается метод _onUpdateEvent
    on<UpdateProfileEvent>(_onUpdateEvent);
    //добавляем событие LoadProfileEvent в самом начале когда открывается экран профиля
    add(const LoadProfileEvent());
  }

  Future<void> _onLoadEvent(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    //перед загрузкой профиля выводим состояние загрузки
    emit(const LoadingProfileState());
    try {
      //загружаем профиль из репозитория
      final user = await _profileRepository.getUser();
      //выводим состояние с загруженным профилем
      emit(LoadedProfileState(user: user));
    } catch (e) {
      emit(ErrorProfileState());
    }
  }

  Future<void> _onEditEvent(EditProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      //выводим состояние с профилем в режиме редактирования
      emit(EditProfileState(user: event.user));
    } catch (e) {
      emit(ErrorProfileState());
    }
  }

  Future<void> _onUpdateEvent(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      //обновляем профиль в репозитории
      await _profileRepository.updateUser(event.user);
      //выводим состояние с обновленным профилем
      emit(LoadedProfileState(user: event.user));
    } catch (e) {
      emit(ErrorProfileState());
    }
  }

}