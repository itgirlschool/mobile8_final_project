import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/model/order_model.dart';
import '../data/model/product_model.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  final List<Order> orders = [
    Order(
      orderId: '1',
      date: DateTime.now(),
      status: 'Доставлен',
      products: [
        Product(
          id: "1",
          name: 'Молоко',
          price: 100,
          quantity: 1,
          description: '1л',
          category: 'Молочные продукты',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
        ),
        Product(
          id: "2",
          name: 'Хлеб',
          price: 50,
          quantity: 2,
          description: 'Белый',
          category: 'Хлебобулочные изделия',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
        ),
      ],
      totalPrice: 150,
    ),
    Order(
      orderId: '2',
      date: DateTime.now(),
      status: 'Доставлен',
      products: [
        Product(
          id: "1",
          name: 'Молоко Parmalat',
          price: 100,
          quantity: 1,
          description: '1л',
          category: 'Молочные продукты',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
        ),
        Product(
          id: "2",
          name: 'Хлеб бородинский',
          price: 50,
          quantity: 2,
          description: 'Белый',
          category: 'Хлебобулочные изделия',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
        ),
      ],
      totalPrice: 150,
    ),
    Order(
      orderId: '3',
      date: DateTime.now(),
      status: 'Доставлен',
      products: [
        Product(
          id: "1",
          name: 'Молоко Parmalat',
          price: 100,
          quantity: 1,
          description: '1л',
          category: 'Молочные продукты',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fparmalat.jpg?alt=media&token=02d30e57-ab38-41bf-962a-252d557b03df',
        ),
        Product(
          id: "2",
          name: 'Хлеб бородинский',
          price: 50,
          quantity: 2,
          description: 'Белый',
          category: 'Хлебобулочные изделия',
          image: 'https://firebasestorage.googleapis.com/v0/b/mobile-4e919.appspot.com/o/products%2Fborodinski.jpg?alt=media&token=90e2523f-4372-4ef8-9cba-5be5feb2f20e',
        ),
      ],
      totalPrice: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Заказы'),
          ),
          body: Center(
            child: Container(
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        DateFormat('dd.MM.yyyy HH:m').format(orders[index].date),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${orders[index].totalPrice.toString()} руб.",
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    orders[index].status,
                                    style: const TextStyle(color: Colors.green, fontSize: 14),
                                  )
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: SizedBox(
                                  width: 300,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: orders[index].products.length,
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
                                              child: Image.network(orders[index].products[i].image, width: 50, height: 50),
                                            ),
                                            Text(orders[index].products[i].name),
                                            Text(' x ${orders[index].products[i].quantity}'),
                                            Spacer(),
                                            Text('${orders[index].products[i].price * orders[index].products[i].quantity} руб.')
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Spacer(),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => const OrderScreen()),
                    //     );
                    //   },
                    //   child: const Text('Экран заказа'),
                    // ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
