import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile8_final_project/bloc/go_to_cart/go_to_cart_bloc.dart';

import '../../bloc/go_to_cart/go_to_cart_state.dart';
import '../cart_screen.dart';

class GoToCartButton extends StatefulWidget {
  final Function onPressed;

  const GoToCartButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<GoToCartButton> createState() => _GoToCartButtonState();
}

class _GoToCartButtonState extends State<GoToCartButton> {
  final _bloc = GoToCartBloc(GetIt.I.get());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: BlocBuilder<GoToCartBloc, GoToCartState>(builder: (context, state) {
        return switch (state) {
          LoadingGoToCartState() => const Padding(padding: const EdgeInsets.all(0.0),),
          LoadedGoToCartState() => _buildButton(context, state.cart.totalPrice),
          ErrorGoToCartState() => const Center(
              child: Text('Ошибка загрузки корзины'),
            ),
        };
      }),
    );
  }

  Padding _buildButton(BuildContext context, price) {
    if( price == 0.0 ) return Padding(padding: const EdgeInsets.all(0.0),);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
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
              widget.onPressed();
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
                    '${price} ₽',
                    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
