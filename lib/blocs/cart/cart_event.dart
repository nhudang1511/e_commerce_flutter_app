import 'package:e_commerce/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable{
  const CartEvent();

  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final Product product;
  const AddProduct(this.product);
  @override
  List<Object> get props => [product];
}
class RemoveProduct extends CartEvent {
  final Product product;
  const RemoveProduct(this.product);
  @override
  List<Object> get props => [product];
}

class RemoveAllProduct extends CartEvent {
  final List<Product> product;
  const RemoveAllProduct(this.product);
  @override
  List<Object> get props => [product];
}

