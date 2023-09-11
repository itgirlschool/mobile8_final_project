import 'package:flutter/material.dart';

import '../cart_screen.dart';


class GoToCartButton extends StatefulWidget {
  final int price;
  const GoToCartButton({
    super.key,
    required this.price,
  });

  @override
  State<GoToCartButton> createState() => _GoToCartButtonState();
}
class _GoToCartButtonState extends State<GoToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 55,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffce50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Color(0xffffce50), width: 0),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Корзина',
                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(
                    '${widget.price} ₽',
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}