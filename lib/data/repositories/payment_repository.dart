import 'package:mobile8_final_project/data/repositories/user_repository.dart';

import '../datasource/payment_remote_datasource.dart';
import '../dto/payment_dto.dart';
import '../model/payment_model.dart';
import '../model/user_model.dart';

class PaymentRepository {
  final PaymentRemoteDatasource _paymentRemoteDatasource;
  final UserRepository userRepository;

  PaymentRepository(this._paymentRemoteDatasource, this.userRepository);

  Future<String> pay(Payment payment) async {
    User user = await userRepository.getUser();
    try{
      final String result = await _paymentRemoteDatasource.pay(PaymentDto(
        email: user.email,
        price: payment.price,
      ));
      return result;
    } catch (e) {
      return e.toString();
    }
  }
}