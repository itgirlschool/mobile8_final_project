import 'dart:async';

import 'package:mobile8_final_project/data/datasource/user_remote_datasource.dart';

import '../dto/user_dto.dart';
import '../model/user_model.dart';

class UserRepository {
  final UserRemoteDatasource _userRemoteDatasource;

  UserRepository(this._userRemoteDatasource);

  Future<String> login(String email, String password) async {
    try {
      final String result = await _userRemoteDatasource.login(email, password);
      return result;
    } catch (e) {
     // print('Ошибка при входе: $e');
      return e.toString();
     // rethrow;
    }
  }

  Future<String> signUp(User user) async {
    try {
      final String result = await _userRemoteDatasource.signUp(
        UserDto(
          email: user.email,
          password: user.password,
          name: user.name,
          phone: user.phone,
          address: user.address,
        ),
      );
      return result;
    } catch (e) {
     // print('Ошибка при регистрации: $e');
      return e.toString();
      //rethrow;
    }
  }

  Future<String> updateUser(User user) async {
    try {
      final String result = await _userRemoteDatasource.updateUser(
        UserDto(
          email: user.email,
          password: user.password,
          name: user.name,
          phone: user.phone,
          address: user.address,
        ),
      );
      return result;
    } catch (e) {
      //print('Ошибка при обновлении данных пользователя: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _userRemoteDatasource.logout();
    } catch (e) {
      //print('Ошибка при выходе: $e');
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      final UserDto result = await _userRemoteDatasource.getUser();
      return User(email: result.email, name: result.name, phone: result.phone, address: result.address, id: result.id);
    } catch (e) {
     // print('Ошибка при получении данных пользователя: $e');
      rethrow;
    }
  }

  bool isUserLoggedIn() {
    return _userRemoteDatasource.isUserLoggedIn();
  }

}
