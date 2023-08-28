import 'package:flutter/material.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const SafeArea(
        child: Scaffold(
          appBar: AppBarWidget(title: 'Название продукта',),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Экран продукта',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
