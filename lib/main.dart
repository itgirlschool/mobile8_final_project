import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/data/datasource/cart_remote_datasource.dart';
import 'package:mobile8_final_project/data/datasource/payment_remote_datasource.dart';
import 'package:mobile8_final_project/data/datasource/products_remote_datasource.dart';
import 'package:mobile8_final_project/data/datasource/user_remote_datasource.dart';
import 'package:mobile8_final_project/screens/categories_screen.dart';
import 'package:mobile8_final_project/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mobile8_final_project/stripe_public_key.dart';
import 'data/datasource/categories_remote_datasource.dart';
import 'data/datasource/orders_remote_datasource.dart';
import 'data/repositories/cart_repository.dart';
import 'data/repositories/categories_repository.dart';
import 'data/repositories/orders_repository.dart';
import 'data/repositories/payment_repository.dart';
import 'data/repositories/products_repository.dart';
import 'data/repositories/user_repository.dart';
import 'firebase_options.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();

  GetIt.I.registerSingleton(CartRemoteDatasource());
  GetIt.I.registerSingleton(CartRepository(GetIt.I.get()));
  GetIt.I.registerSingleton(OrdersRemoteDatasource());
  GetIt.I.registerSingleton(OrdersRepository(GetIt.I.get()));
  GetIt.I.registerSingleton(UserRemoteDatasource());
  GetIt.I.registerSingleton(UserRepository(GetIt.I.get()));
  GetIt.I.registerSingleton(PaymentRemoteDatasource());
  GetIt.I.registerSingleton(PaymentRepository(GetIt.I.get(), GetIt.I.get()));
  GetIt.I.registerSingleton(CategoriesRemoteDatasource());
  GetIt.I.registerSingleton(CategoriesRepository(GetIt.I.get()));
  GetIt.I.registerSingleton(ProductsRemoteDatasource());
  GetIt.I.registerSingleton(ProductsRepository(GetIt.I.get()));
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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green).copyWith(
          background: const Color(0xFFFFFFFF),
          surfaceTint: Colors.white,
        ),
      ),
      home: _startingRoute(),
    );
  }

  Widget _startingRoute() {
    UserRepository userRepository = GetIt.I.get();
    if (userRepository.isUserLoggedIn()) {
      return const CategoriesScreen();
    }
    return const LoginScreen();
  }
}
