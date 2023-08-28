import 'package:flutter/material.dart';
import 'package:mobile8_final_project/screens/widgets/drawer.dart';
import '../data/model/cart_model.dart';
import '../data/model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Cart cart = Cart(
    products: [
      Product(
        id: "1",
        name: 'Молоко Parmalat',
        price: 100,
        quantity: 1,
        description: '1л',
        category: 'Молочные продукты',
        image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
      ),
      Product(
        id: "2",
        name: 'Хлеб бородинский',
        price: 50,
        quantity: 2,
        description: 'Белый',
        category: 'Хлебобулочные изделия',
        image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
      ),
    ],
    totalPrice: 150,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Корзина'),
          ),
          drawer: const DrawerWidget(),
          body: const Center(
            child: Text(
              'Корзина',
            ),
          ),
        ),
      ),
    );
  }
}

