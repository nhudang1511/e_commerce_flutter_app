import 'package:equatable/equatable.dart';

import '../../models/models.dart';

abstract class ProductEvent extends Equatable{
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  @override
  List<Object> get props => [];
}

class UpdateProducts extends ProductEvent {
  final List<Product> products;
  const UpdateProducts(this.products);

  @override
  List<Object> get props => [products];
}