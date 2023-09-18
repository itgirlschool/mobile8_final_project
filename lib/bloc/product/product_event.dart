import 'package:mobile8_final_project/bloc/product/product_state.dart';

import '../../data/model/product_model.dart';

class ProductEvent {

}

class LoadProductEvent extends ProductEvent {
  final String id;
  LoadProductEvent(this.id);
}

class AddProductToCart extends ProductEvent {
  final Product product;
  LoadedProductState state;
  AddProductToCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddProductToCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}

class RemoveProductFromCart extends ProductEvent {
  final Product product;
  LoadedProductState state;
  RemoveProductFromCart({required this.product, required this.state});

  @override
  bool operator ==(Object other) => identical(this, other) || other is RemoveProductFromCart && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}