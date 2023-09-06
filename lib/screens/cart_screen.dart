import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';
import 'package:mobile8_final_project/screens/widgets/drawer.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../data/model/product_model.dart';
import '../data/repositories/orders_repository.dart';
import '../data/repositories/payment_repository.dart';
import '../main.dart';
import '../data/repositories/cart_repository.dart';
import '../data/repositories/user_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _bloc = CartBloc(getIt<CartRepository>(), getIt<UserRepository>(), getIt<PaymentRepository>(), getIt<OrdersRepository>());

//раскомментить для тестовых данных
  // Cart cart = Cart(
  //   products: [
  //     Product(
  //       id: "1",
  //       name: 'Молоко Parmalat',
  //       price: 100,
  //       quantity: 1,
  //       description: '1л',
  //       category: '1',
  //       image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  //     ),
  //     Product(
  //       id: "2",
  //       name: 'Хлеб бородинский ',
  //       price: 50,
  //       quantity: 1,
  //       description: 'Белый',
  //       category: '3',
  //       image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  //     ),
  //     Product(
  //       id: "1",
  //       name: 'Молоко Parmalat',
  //       price: 100,
  //       quantity: 1,
  //       description: '1л',
  //       category: '1',
  //       image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  //     ),
  //     Product(
  //       id: "2",
  //       name: 'Хлеб бородинский ',
  //       price: 50,
  //       quantity: 1,
  //       description: 'Белый',
  //       category: '3',
  //       image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  //     ),
  //   ],
  //   totalPrice: 150,
  // );

  List<Product> products = [
    Product(
      id: "7feHotmB2nnrRB8KOvXB",
      name: 'Молоко Parmalat',
      price: 100,
      quantity: 1,
      description: '1л',
      category: '1',
      image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
    ),
    Product(
      id: "pflljuRHtgBBMK2jEnPI",
      name: 'Хлеб бородинский ',
      price: 50,
      quantity: 1,
      description: 'Черный, 400гр, Зерновой край',
      category: '3',
      image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
    ),
  ];

  // List categories = [
  //   {
  //     "name": "Молочные продукты",
  //     "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmilk.png?alt=media&token=0c8081f0-ef0a-4b25-965e-3379a1d1e523",
  //     "category": "1",
  //   },
  //   {
  //     "name": "Мясо",
  //     "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fmeat.png?alt=media&token=fa75f3da-27a1-4cb5-8f6c-38f4fc12cbfc",
  //     "category": "1",
  //   },
  //   {
  //     "name": "Хлеб",
  //     "image": "https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/categories%2Fbread.png?alt=media&token=35d8ddfc-7652-4fdb-af23-e840827b997a",
  //     "category": "1",
  //   },
  // ];
  //
  // final String _address = 'Ленинского комсомола 1А, кв. 10';

  @override
  void initState() {
    //раскомментить для тестовых данных
    final CartRepository _cartRepository = getIt<CartRepository>();
    //_cartRepository.addProductToCart(products[0]);
    //_cartRepository.addProductToCart(products[1]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(title: 'Корзина'),
        drawer: const DrawerWidget(),
        body: BlocProvider(
          create: (_) => _bloc,
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
                LoadedCartState() => (state.cart.products.isNotEmpty)
                    ? _buildCart(context, state)
                    : Center(
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
                      ),
                ErrorCartState() => const Center(
                    child: Text('Ошибка при загрузке корзины'),
                  ),
                PaymentErrorCartState() => _buildPaymentError(context),
              };
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildCart(BuildContext context, LoadedCartState state) {
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
            child: Padding(
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
                          PayEvent(totalPrice: state.cart.totalPrice),
                        );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Оформить заказ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        '${state.cart.totalPrice} руб.',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          )
        ],
      );
    });
  }

  ListTile _buildProductTile(int index, LoadedCartState state) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 0),
      leading: Image.network(
        state.cart.products[index].image,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return const Icon(Icons.image);
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(Icons.image_not_supported);
        },
      ),
      trailing: _buildButtons(index, state),
      title: Text(
        state.cart.products[index].name,
        overflow: TextOverflow.ellipsis,
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
            ),
          ),
          Text('${state.cart.products[index].price} руб.'),
        ],
      ),
    );
  }

  Widget _buildButtons(int index, LoadedCartState state) {
    return Builder(builder: (context) {
      return SizedBox(
        width: 100,
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 35,
              height: 30,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 20,
                onPressed: () {
                  context.read<CartBloc>().add(
                        RemoveProductFromCart(product: state.cart.products[index]),
                      );
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.green,
                ),
              ),
            ),
            Text(
              '${state.cart.products[index].quantity}',
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              width: 35,
              height: 30,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20,
                  onPressed: () {
                    if (state.stock[state.cart.products[index].id] != null && (state.stock[state.cart.products[index].id]! > state.cart.products[index].quantity)) {
                      context.read<CartBloc>().add(
                            AddProductToCart(product: state.cart.products[index]),
                          );
                    }
                  },
                  icon: (state.stock[state.cart.products[index].id] != null && (state.stock[state.cart.products[index].id]! > state.cart.products[index].quantity))
                      ? const Icon(Icons.add_circle, color: Colors.green)
                      : const Icon(Icons.add_circle, color: Colors.grey)),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPaymentError(BuildContext context) {
    context.read<CartBloc>().add(
          (LoadCartEvent()),
        );
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
