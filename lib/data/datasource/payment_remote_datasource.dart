import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '../../stripe_public_key.dart';
import '../dto/payment_dto.dart';

class PaymentRemoteDatasource {
  Future<String> pay(PaymentDto paymentDto) async {
    try {
      // 1. create payment intent on the server
      final response = await http.post(
          Uri.parse(
            urlFunctionPaymentIntentRequest,
          ),
          body: {
            'email': paymentDto.email,
            'amount': paymentDto.price.toString(),
          });

      final jsonResponse = jsonDecode(response.body);
      Stripe.instance.resetPaymentSheetCustomer();
      //2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Ярмаркет',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
          style: ThemeMode.light,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      return 'success';
    } catch (e) {
      return e.toString();
      // if (e is StripeException) {
      //   throw 'Ошибка Stripe: ${e.error.localizedMessage}';
      // } else {
      //   throw 'Ошибка: ${e.toString()}';
      // }
    }
  }
}