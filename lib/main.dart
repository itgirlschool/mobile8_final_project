import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/data/datasource/cart_remote_datasource.dart';
import 'package:mobile8_final_project/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/cart_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton(CartRemoteDatasource());
  GetIt.I.registerSingleton(CartRepository(GetIt.I.get()));
  runApp(const FoodShopApp());
}

class FoodShopApp extends StatelessWidget {
  const FoodShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Магазин продуктов',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
