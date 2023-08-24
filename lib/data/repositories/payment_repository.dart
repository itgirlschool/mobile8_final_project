import '../datasource/payment_remote_datasource.dart';
import '../dto/payment_dto.dart';
import '../model/payment_model.dart';

class PaymentRepository {
  final PaymentRemoteDatasource _paymentRemoteDatasource;

  PaymentRepository(this._paymentRemoteDatasource);
  //TODO: поменять на доставание имейла из юзера через репозиторий
  String email = '1@gmail.com';

  Future<String> pay(Payment payment) async {
    try{
      final String result = await _paymentRemoteDatasource.pay(PaymentDto(
        email: email,
        price: payment.price,
      ));
      return result;
    } catch (e) {
      return 'error';
      // print('Ошибка при оплате: $e');
      // throw e;
    }
  }
}