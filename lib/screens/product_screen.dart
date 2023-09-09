import 'package:flutter/material.dart';
import 'package:mobile8_final_project/data/dto/product_dto.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/mock_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductDto product = products[0];
  bool isInCart = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBarWidget(
              title: product.name,
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: NetworkImage(product.image))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(product.description),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: isInCart
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_circle_outline_sharp)),
                            Text('1'),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_circle_outline_sharp))
                          ],
                        )
                      : ElevatedButton(
                          onPressed: () {
                            isInCart = true;
                          },
                          child: Text('В корзину'),
                        ),
                )
              ]),
            )),
      ),
    );
  }
}
