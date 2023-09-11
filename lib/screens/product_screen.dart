import 'package:flutter/material.dart';
import 'package:mobile8_final_project/data/dto/product_dto.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';
import 'package:mobile8_final_project/screens/widgets/go_to_cart_button.dart';

class ProductScreen extends StatefulWidget {
  final ProductDto product;

  ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  ProductDto product;
  bool isInCart = true;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const GoToCartButton(price: 300,),
            appBar: AppBarWidget(
              title: product.name,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: const Color(0xffeeeeee),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Card(
                    color: Colors.white,
                    child: Column(

                        children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(product.image))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(product.description, style: TextStyle(fontSize: 18, )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CartButtons(
                        onPressedAdd: (){},
                        onPressedRemove: (){},
                        isInStock: true,
                        quantity: 0,
                        price: 100,
                        sizeFactor: 1.8,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
