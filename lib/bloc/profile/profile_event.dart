import '../../data/model/user_model.dart';

// Абстрактный класс ProfileEvent
class ProfileEvent {
  const ProfileEvent();
}

// Событие загрузки профиля
class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

// Событие редактирования профиля, которое отображается при нажатии кнопки редактирования
class EditProfileEvent extends ProfileEvent {
  final User user;

  const EditProfileEvent({required this.user});

  // Переопределяем оператор сравнения, это нужно в случае если мы будем сравнивать события одного типа по оператору сравнения, чтобы узнать изменилось ли событие
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditProfileEvent && runtimeType == other.runtimeType && user == other.user;

  // Переопределяем hashCode, это в случае если мы будем сравнивать события по hashCode
  @override
  int get hashCode => user.hashCode;
}

// Событие обновления профиля, которое происходит при нажатии кнопки сохранения
class UpdateProfileEvent extends ProfileEvent {
  final User user;

  const UpdateProfileEvent({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UpdateProfileEvent && runtimeType == other.runtimeType && user == other.user;

  @override
  int get hashCode => user.hashCode;
}

// Событие ошибки
class ProfileErrorEvent extends ProfileEvent {}