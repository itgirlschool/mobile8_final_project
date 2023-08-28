import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobile8_final_project/screens/widgets/appbar.dart';

import '../bloc/orders_history/orders_history_bloc.dart';
import '../bloc/orders_history/orders_history_state.dart';
import '../data/model/order_model.dart';
import '../data/model/product_model.dart';
import '../data/repositories/orders_repository.dart';
import '../main.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  final _bloc = OrdersHistoryBloc(getIt<OrdersRepository>());

  // final List<Order> orders = [
  //   Order(
  //     orderId: '1',
  //     date: DateTime.now(),
  //     status: 'Доставлен',
  //     products: [
  //       Product(
  //         id: "1",
  //         name: 'Молоко',
  //         price: 100,
  //         quantity: 1,
  //         description: '1л',
  //         category: 'Молочные продукты',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  //       ),
  //       Product(
  //         id: "2",
  //         name: 'Хлеб',
  //         price: 50,
  //         quantity: 2,
  //         description: 'Белый',
  //         category: 'Хлебобулочные изделия',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  //       ),
  //     ],
  //     totalPrice: 150,
  //   ),
  //   Order(
  //     orderId: '2',
  //     date: DateTime.now(),
  //     status: 'Доставлен',
  //     products: [
  //       Product(
  //         id: "1",
  //         name: 'Молоко Parmalat ffffffffff fffff fff',
  //         price: 100,
  //         quantity: 1,
  //         description: '1л',
  //         category: 'Молочные продукты',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  //       ),
  //       Product(
  //         id: "2",
  //         name: 'Хлеб бородинский',
  //         price: 50,
  //         quantity: 2,
  //         description: 'Белый',
  //         category: 'Хлебобулочные изделия',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  //       ),
  //     ],
  //     totalPrice: 150,
  //   ),
  //   Order(
  //     orderId: '3',
  //     date: DateTime.now(),
  //     status: 'Доставлен',
  //     products: [
  //       Product(
  //         id: "1",
  //         name: 'Молоко Parmalat',
  //         price: 100,
  //         quantity: 1,
  //         description: '1л',
  //         category: 'Молочные продукты',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
  //       ),
  //       Product(
  //         id: "2",
  //         name: 'Хлеб бородинский',
  //         price: 50,
  //         quantity: 2,
  //         description: 'Белый',
  //         category: 'Хлебобулочные изделия',
  //         image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
  //       ),
  //     ],
  //     totalPrice: 150,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: const AppBarWidget(
            title: 'История заказов',
          ),
          body: Center(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: BlocProvider(
                        create: (_) => _bloc,
                        child: BlocBuilder<OrdersHistoryBloc, OrdersHistoryState>(builder: (context, state) {
                          return switch (state) {
                            LoadingOrdersHistoryState() => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            LoadedOrdersHistoryState() => _buildOrdersList(state),
                            ErrorOrdersHistoryState() => const Center(
                                child: Text('Ошибка загрузки данных'),
                              ),
                          };
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList(state) {
    return ListView.builder(
      itemCount: state.orders.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: ListTile(
            title: _buildOrderHeader(state.orders[index]),
            subtitle: _buildProductsList(state.orders[index]),
          ),
        );
      },
    );
  }

  Widget _buildProductsList(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: SizedBox(
        width: 300,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: order.products.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.network(
                      order.products[i].image,
                      width: 50,
                      height: 50,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.image_not_supported);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(order.products[i].name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ),
                  Text(' x ${order.products[i].quantity}'),
                  const Spacer(),
                  Text('${order.products[i].price * order.products[i].quantity} руб.')
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd.MM.yyyy HH:m').format(order.date),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${order.totalPrice.toString()} руб.",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          order.status,
          style: const TextStyle(color: Colors.green, fontSize: 14),
        )
      ],
    );
  }
}
