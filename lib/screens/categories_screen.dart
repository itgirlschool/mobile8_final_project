import 'package:flutter/material.dart';
import 'package:mobile8_final_project/screens/products_in_category_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/drawer.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Ярмаркет',
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Категории продуктов',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProductsInCategoryScreen()),
                  );
                },
                child: const Text('Экран продуктов в категории'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}