import 'package:flutter/material.dart';
import 'package:mobile8_final_project/screens/product_screen.dart';

class ProductsInCategoryScreen extends StatefulWidget {
  const ProductsInCategoryScreen({super.key});

  @override
  State<ProductsInCategoryScreen> createState() => _ProductsInCategoryScreenState();
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Категория продуктов'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Продукты в категории',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProductScreen()),
                    );
                  },
                  child: const Text('Экран продукта'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
