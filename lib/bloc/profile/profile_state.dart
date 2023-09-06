import '../../data/model/user_model.dart';

//Родительский класс для состояний экрана
sealed class ProfileState {
  const ProfileState();
}

// Начальное состояние экрана
class LoadingProfileState extends ProfileState {
  const LoadingProfileState();
}

// Состояние экрана с уже загруженными данными
class LoadedProfileState extends ProfileState {
 final User user;

  const LoadedProfileState({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoadedProfileState && runtimeType == other.runtimeType && user == other.user;

  @override
  int get hashCode => user.hashCode;
}

// Состояние экрана во время редактирования
class EditProfileState extends ProfileState {
  final User user;

  const EditProfileState({required this.user});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditProfileState && runtimeType == other.runtimeType && user == other.user;

  @override
  int get hashCode => user.hashCode;
}

// Состояние экрана с ошибкой
class ErrorProfileState extends ProfileState {}