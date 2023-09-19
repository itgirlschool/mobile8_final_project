import 'package:flutter/material.dart';
import 'package:mobile8_final_project/data/repositories/user_repository.dart';
import 'package:mobile8_final_project/screens/register_screen.dart';

import '../main.dart';
import 'categories_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffb7ff9d),
              Color(0xff2abb34),
            ],
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(

                    'assets/groceries_no_bg.png',
                    width: 200,
                    height: 200,
                  ),

                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      'Ярмаркет',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _loginController,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Логин (электронная почта)',
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.0,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Пароль',
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                          width: 0.0,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffd5ffca),

                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text(
                      'Войти',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text(
                      'Регистрация',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _login() async {
    final String login = _loginController.text;
    final String password = _passwordController.text;
    try {
      String result = await getIt.get<UserRepository>().login(login, password);
      if (result == 'success') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
        );
      } else {
        _buildErrorMessage();
      }
    } catch (e) {
      _buildErrorMessage();
      //print('Ошибка при входе: $e');
    }
  }

  Future<void> _buildErrorMessage() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ошибка авторизации'),
          content: const Text('Неверный логин или пароль'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('ОК'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
