import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/wishlist_model.dart';

import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishListLoading()){
    on<LoadWishlist>(_onLoadWishlist);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  void _onLoadWishlist(event, Emitter<WishlistState> emit) async{
    emit(WishListLoading());
    try{
      await Future<void>.delayed(Duration(seconds: 1));
      emit(WishListLoaded());
    }
    catch(_){
      emit(WishListError());
    }
  }
  void _onAddProductToWishlist(event, Emitter<WishlistState> emit) async{
    final state = this.state;
    if(state is WishListLoaded){
      try{
        emit(WishListLoaded(wishlist: Wishlist(products: List.from(state.wishlist.products)..add(event.product))));
      }
      on Exception{
        emit(WishListError());
      }
    }
  }
  void _onRemoveProductFromWishlist(event, Emitter<WishlistState> emit) async{
    final state = this.state;
    if(state is WishListLoaded){
      try{
        emit(WishListLoaded(wishlist: Wishlist(products: List.from(state.wishlist.products)..remove(event.product))));
      }
      on Exception{
        emit(WishListError());
      }
    }
  }

  // @override
  // Stream<WishlistState> mapEventToState(WishlistEvent event) async*{
  //   if(event is StartWishlist){
  //     yield* _mapStartWishlistToState();
  //   }
  //   else if(event is AddWishlistProduct){
  //     yield* _mapAddWishlistProductToState(event, state);
  //   } else if(event is RemoveWishlistProduct){
  //     yield* _mapRemoveWishlistProductToState(event, state);
  //   }
  // }
  // Stream<WishlistState> _mapStartWishlistToState() async*{
  //   yield WishListLoading();
  //   try{
  //     await Future<void>.delayed(Duration(seconds: 1));
  //     yield const WishListLoaded();
  //   }
  //   catch(_){}
  // }
  // Stream<WishlistState> _mapAddWishlistProductToState(
  //     AddWishlistProduct event, WishlistState state
  //     ) async*{
  //   if(state is WishListLoaded){
  //     try{
  //       yield WishListLoaded(wishlist: Wishlist(products: List.from(state.wishlist.products)..add(event.product)));
  //     }
  //     catch(_){}
  //   }
  // }
  // Stream<WishlistState> _mapRemoveWishlistProductToState(
  //     RemoveWishlistProduct event, WishlistState state
  //     ) async*{
  //   if(state is WishListLoaded){
  //     try{
  //       yield WishListLoaded(wishlist: Wishlist(products: List.from(state.wishlist.products)..remove(event.product)));
  //     }
  //     catch(_){}
  //   }
  //
  // }
}
