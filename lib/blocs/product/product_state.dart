import 'package:equatable/equatable.dart';
import '../../models/models.dart';
abstract class ProductState extends Equatable{
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState{
  @override
  List<Object> get props => [];
}

class ProductLoaded extends ProductState{

  final List<Product> products;

  const ProductLoaded({this.products = const <Product>[]});
  @override
  List<Object> get props => [products];
}
