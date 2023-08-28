import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.index = 0});

  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState(currentIndex: index);
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex;

  _HomeScreenState({this.currentIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        //backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        onTap: (value) {
          // Respond to item press.
          setState(() => currentIndex = value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ],
      ),
      body:
      <Widget>[
        const CategoriesScreen(),
        const CartScreen()
      ][currentIndex],

    );
  }
}
