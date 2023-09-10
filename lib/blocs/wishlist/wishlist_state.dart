import 'package:e_commerce/models/wishlist_model.dart';
import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {

  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishListLoading extends WishlistState{
  @override
  List<Object> get props => [];
}
class WishListLoaded extends WishlistState{
  final Wishlist wishlist;
  const WishListLoaded  ({this.wishlist = const Wishlist()});

  @override
  List<Object> get props => [wishlist];
}
class WishListError extends WishlistState{
  @override
  List<Object> get props => [];
}
