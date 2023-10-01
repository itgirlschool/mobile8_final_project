import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/bloc/product/product_bloc.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';
import 'package:mobile8_final_project/screens/widgets/go_to_cart_button.dart';
import 'package:mobile8_final_project/bloc/product/product_event.dart';

import '../bloc/product/product_state.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final String productId;
  final String productName;

  ProductScreen({super.key, required this.productId, required this.productName});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  _ProductScreenState();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocProvider(
          create: (context) => ProductBloc(GetIt.I.get(), GetIt.I.get(), widget.productId),
          child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            return switch (state) {
              LoadingProductState() => _buildScaffold(context, const Center(child: CircularProgressIndicator())),
              LoadedProductState() => _buildScaffold(context, _buildProduct(context, state)),
              ErrorProductState() => _buildScaffold(context, const Center(child: Text('Ошибка загрузки товара'))),
            };
          }),
        ),

      ),
    );
  }

  Scaffold _buildScaffold(BuildContext context, Widget child) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GoToCartButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));},),
        appBar: AppBarWidget(
          title: widget.productName,
        ),
        body: child,
      );
  }

  Widget _buildProduct(BuildContext context, state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: const Color(0xffeeeeee),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            child: Column(children: [
              Container(
                height: 300,
                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(state.product.image))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(state.product.description,
                    style: const TextStyle(
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              CartButtons(
                onPressedAdd: () {
                  context.read<ProductBloc>().add(AddProductToCart(product: state.product, state: state, stock: state.stock, inCart: state.inCart));
                },
                onPressedRemove: () {
                  context.read<ProductBloc>().add(RemoveProductFromCart(product: state.product, state: state, stock: state.stock, inCart: state.inCart));
                },
                isInStock: state.stock > state.inCart,
                quantity: state.inCart,
                price: state.product.price,
                sizeFactor: 1.8,
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
