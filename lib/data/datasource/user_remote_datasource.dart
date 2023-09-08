import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../dto/user_dto.dart';

class UserRemoteDatasource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } on FirebaseAuthException catch (e) {
      // Код ошибка для случая, если пользователь не найден
      return e.code;
    }
  }

  Future<String> signUp(UserDto user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      CollectionReference profileReference = firestore.collection('profiles');
      await profileReference.doc(userCredential.user!.uid).set({
        'name': user.name,
        'phone': user.phone,
        'address': user.address,
      });
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Пароль слишком простой.';
      } else if (e.code == 'email-already-in-use') {
        return 'Пользователь с таким email уже существует.';
      } else if (e.code == 'invalid-email') {
        return 'Неверный email.';
      }
    } catch (e) {
      return "Ошибка";
    }
    return "Ошибка";
  }

  Future<String> updateUser(UserDto user) async {

    try {
      //var userId = '4';

      User userFirebase = FirebaseAuth.instance.currentUser!;
      CollectionReference profileReference = firestore.collection('profiles');
      await profileReference.doc(userFirebase.uid).update({
      //await profileReference.doc(userId).update({
        'name': user.name,
        'phone': user.phone,
        'address': user.address,
      });
      return "success";
    } catch (e) {
      return "Ошибка";
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  // Метод для изменения пароля пользователя
  Future<bool> changePassword(String email, String currentPassword, String newPassword) async {
    User user = FirebaseAuth.instance.currentUser!; // Получаем текущего пользователя

    // Создаем объект учетных данных для проведения проверки подлинности
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);

    try {
      // Проверяем подлинность пользователя с использованием текущих учетных данных
      await user.reauthenticateWithCredential(credential);

      // Меняем пароль на новый
      await user.updatePassword(newPassword);
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<UserDto> getUser() async {

    User user = FirebaseAuth.instance.currentUser!;
   // var userId = '4';
    try {
      DocumentReference profileReference = firestore.collection('profiles').doc(user.uid);
      //DocumentReference profileReference = firestore.collection('profiles').doc(userId);
      DocumentSnapshot profileSnapshot = await profileReference.get();
      if (!profileSnapshot.exists) {
        throw Exception('Пользователь не найден');
      } else {
        var profile = profileSnapshot.data() as Map<String, dynamic>;
        return UserDto(
          id: user.uid,
          //id: userId,
          name: profile['name'],
          //email: "email@e.com",
          email: user.email!,
          phone: profile['phone'],
          address: profile['address'],
        );
      }
    } catch (e) {
      throw Exception('Ошибка при получении пользователя');
    }
  }

  bool isUserLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}