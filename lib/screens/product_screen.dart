import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/bloc/product/product_bloc.dart';
import 'package:mobile8_final_project/data/dto/product_dto.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';
import 'package:mobile8_final_project/screens/widgets/go_to_cart_button.dart';

import '../bloc/product/product_state.dart';

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
    final _bloc = ProductBloc(GetIt.I.get(), GetIt.I.get(), widget.productId);

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const GoToCartButton(),
          appBar: AppBarWidget(
            title: widget.productName,
          ),
          body: BlocProvider(
            create: (context) => _bloc,
            child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              return switch (state) {
                LoadingProductState() => const Center(child: CircularProgressIndicator()),
                LoadedProductState() => _buildProduct(context, state),
                ErrorProductState() => const Center(child: Text('Ошибка при загрузке товара')),
              };
            }),
          ),
        ),
      ),
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
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              CartButtons(
                onPressedAdd: () {},
                onPressedRemove: () {},
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
    );
  }
}
