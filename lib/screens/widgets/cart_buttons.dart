import 'package:flutter/material.dart';

class CartButtons extends StatefulWidget {
  final Function onPressedAdd;
  final Function onPressedRemove;
  final bool isInStock;
  final int quantity;
  final double sizeFactor;
  final int price;
  final bool onlyPrice;

  const CartButtons({
    super.key,
    required this.onPressedAdd,
    required this.onPressedRemove,
    required this.isInStock,
    required this.quantity,
    this.sizeFactor = 1,
    required this.price,
    this.onlyPrice = false,
  });

  @override
  State<CartButtons> createState() => _CartButtonsState();
}

class _CartButtonsState extends State<CartButtons> {
  @override
  Widget build(BuildContext context) {
    if (widget.quantity > 0) {
      return SizedBox(
        width: 90 * widget.sizeFactor,
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 35 * widget.sizeFactor,
              height: 30 * widget.sizeFactor,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                iconSize: 20 * widget.sizeFactor,
                onPressed: () {
                  widget.onPressedRemove();
                },
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.green,
                ),
              ),
            ),
            Text(
              widget.quantity.toString(),
              style: TextStyle(fontSize: 16 * widget.sizeFactor),
            ),
            SizedBox(
              width: 35 * widget.sizeFactor,
              height: 30 * widget.sizeFactor,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  iconSize: 20 * widget.sizeFactor,
                  onPressed: () {
                   if (widget.isInStock) widget.onPressedAdd();
                  },
                  icon: (widget.isInStock) ? const Icon(Icons.add_circle, color: Colors.green) : const Icon(Icons.add_circle, color: Colors.grey)),
            ),
          ],
        ),
      );
    } else if (!widget.onlyPrice) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              widget.onPressedAdd();
            },
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text(
                'В корзину',
                style: TextStyle(fontSize: 13 * widget.sizeFactor, fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(
            width: 10 * widget.sizeFactor,
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Text(
                  '${widget.price} ₽',
                  style: TextStyle(fontSize: 15 * widget.sizeFactor, fontWeight: FontWeight.normal),
                ),
              ))
        ],
      );
    }
    else {
     return  ElevatedButton(
        onPressed: () {
          widget.onPressedAdd();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            '${widget.price.toString()} ₽',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ),
      );
    }
  }
}
