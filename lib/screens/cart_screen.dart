import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/cart_buttons.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(title: 'Корзина'),
          //drawer: const DrawerWidget(),
          body: BlocProvider(
            create: (_) => CartBloc(GetIt.I.get(), GetIt.I.get(), GetIt.I.get(), GetIt.I.get()),
            child: BlocListener<CartBloc, CartState>(
              listenWhen: (previous, current) {
                if (previous is LoadedCartState && current is PaymentErrorCartState) {
                  return true;
                }
                return false;
              },
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Оплата не прошла'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return switch (state) {
                  LoadingCartState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  LoadedCartState() => (state.cart.products.isNotEmpty) ? _buildCart(context, state, false) : _buildEmptyCart(),
                  PaymentLoadingCartState() => (state.cart.products.isNotEmpty) ? _buildCart(context, state, true) : _buildEmptyCart(),
                  ErrorCartState() => const Center(
                      child: Text('Ошибка при загрузке корзины'),
                    ),
                  PaymentErrorCartState() => _buildPaymentError(context),
                };
              }),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_cart.jpg',
            height: 200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffb7ff9d),
                    Color(0xff2abb34),
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Корзина пуста',
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                  //color: Colors.orange,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCart(BuildContext context, state, bool paymentLoading) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              state.address,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 11,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              itemCount: state.cart.products.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    _buildProductTile(index, state),
                    const Divider(
                      height: 3,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: !paymentLoading
                ? Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          context.read<CartBloc>().add(
                                PayEvent(cart: state.cart, stock: state.stock, address: state.address),
                              );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Оформить заказ',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              '${state.cart.totalPrice} ₽',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      );
    });
  }

  Widget _buildProductTile(int index, state) {
    return Builder(
      builder: (context) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
          leading: Image.network(
            state.cart.products[index].image,
            width: 60,
          ),
          trailing: CartButtons(
            onPressedAdd: () {
              if (state.stock[state.cart.products[index].id] != null && (state.stock[state.cart.products[index].id]! > state.cart.products[index].quantity)) {
                context.read<CartBloc>().add(
                      AddProductToCart(product: state.cart.products[index], state: state),
                    );
              }
            },
            onPressedRemove: () {
              context.read<CartBloc>().add(
                    RemoveProductFromCart(product: state.cart.products[index], state: state),
                  );
            },
            isInStock: (state.stock[state.cart.products[index].id] != null && (state.stock[state.cart.products[index].id]! > state.cart.products[index].quantity)),
            quantity: state.cart.products[index].quantity,
            price: state.cart.products[index].price,
            sizeFactor: 1.2,
          ),
          title: Text(
            state.cart.products[index].name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,

            )
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  state.cart.products[index].description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,

                    )
                ),
              ),
              SizedBox(height: 6,),
              Text('${state.cart.products[index].price} ₽.',  style: const TextStyle(
                fontSize: 16,

              )),
            ],
          ),
        );
      }
    );
  }

  Widget _buildPaymentError(BuildContext context) {
    context.read<CartBloc>().add(
          (const LoadCartEvent()),
        );
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
