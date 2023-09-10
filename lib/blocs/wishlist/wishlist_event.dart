import 'package:equatable/equatable.dart';

import '../../models/product_model.dart';

abstract class WishlistEvent extends Equatable{
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class StartWishlist extends WishlistEvent {
  @override
  List<Object> get props => [];
}

class AddWishlistProduct extends WishlistEvent {
  final Product product;
  const AddWishlistProduct  ({required this.product});

  @override
  List<Object> get props => [product];
}

class RemoveWishlistProduct extends WishlistEvent {
  final Product product;
  const RemoveWishlistProduct  ({required this.product});

  @override
  List<Object> get props => [product];
}