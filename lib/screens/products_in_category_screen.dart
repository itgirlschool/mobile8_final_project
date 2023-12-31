import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/bloc/products_in_category/products_in_category_event.dart';
import 'package:mobile8_final_project/screens/product_screen.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';
import 'package:mobile8_final_project/screens/widgets/go_to_cart_button.dart';

import '../bloc/products_in_category/products_in_category_bloc.dart';
import '../bloc/products_in_category/products_in_category_state.dart';
import 'cart_screen.dart';

class ProductsInCategoryScreen extends StatefulWidget {
  final String categId;
  final String categName;

  const ProductsInCategoryScreen({super.key, required this.categId, required this.categName});

  @override
  State<ProductsInCategoryScreen> createState() => _ProductsInCategoryScreenState();
}

class _ProductsInCategoryScreenState extends State<ProductsInCategoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: BlocProvider(
          create: (_) => ProductsInCategoryBloc(GetIt.I.get(), widget.categId, GetIt.I.get()),
          child: BlocBuilder<ProductsInCategoryBloc, ProductsInCategoryState>(builder: (context, state) {
            return switch (state) {
              LoadingProductsInCategoryState() => _buildLoading(),
              LoadedProductsInCategoryState() => _buildProducts(context, state),
              ErrorProductsInCategoryState() => _buildError(),
            };
          }),
        ),
      ),
    );
  }


  Widget _buildLoading() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GoToCartButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
          context.read<ProductsInCategoryBloc>().add(UpdateProductsInCategoryEvent(categoryId: widget.categId));
        },
      ),
      appBar: AppBarWidget(
        title: widget.categName,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError() {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GoToCartButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
          context.read<ProductsInCategoryBloc>().add(UpdateProductsInCategoryEvent(categoryId: widget.categId));
        },
      ),
      appBar: AppBarWidget(
        title: widget.categName,
      ),
      body: const Center(
        child: Text('Ошибка загрузки продуктов'),
      ),
    );
  }

  Widget _buildProducts(BuildContext context, state) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GoToCartButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
          context.read<ProductsInCategoryBloc>().add(UpdateProductsInCategoryEvent(categoryId: widget.categId));
        },
      ),
      appBar: AppBarWidget(
        title: widget.categName,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xfffce6ee),
        //color: Color(0xffe2f5d6),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: GridView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 10/11,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length,
                itemBuilder: (_, index) {
                  return _buildInkProduct(context, state, index);
                }),
          ),
        ),
      ),
    );
  }

  InkWell _buildInkProduct(BuildContext context, state, int index) {
    var inCart = 0;
    for (var i = 0; i < state.cart.products.length; i++) {
      if (state.cart.products[i].id == state.products[index].id) {
        inCart = state.cart.products[i].quantity;
      }
    }
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductScreen(
                    productId: state.products[index].id,
                    productName: state.products[index].name,
                  )),
        );
        context.read<ProductsInCategoryBloc>().add(UpdateProductsInCategoryEvent(categoryId: widget.categId));
      },
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          state.products[index].image,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  state.products[index].name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),

              CartButtons(
                onPressedAdd: () {
                  context.read<ProductsInCategoryBloc>().add(AddProductToCart(product: state.products[index], state: state, cart: state.cart));
                },
                onPressedRemove: () {
                  context.read<ProductsInCategoryBloc>().add(RemoveProductFromCart(product: state.products[index], state: state, cart: state.cart));
                },
                isInStock: state.products[index].quantity > inCart,
                quantity: inCart,
                price: state.products[index].price,
                sizeFactor: 1,
                onlyPrice: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
