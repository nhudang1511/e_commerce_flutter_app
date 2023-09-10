import 'package:bloc/bloc.dart';

import '../../models/models.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    }else if(event is CartProductAdded){
      yield* _mapCartProductAddedToState(event, state);
    }else if(event is CartProductRemoved){
      yield* _mapCartProductRemovedToState(event, state);
    }
  }
  Stream<CartState> _mapCartStartedToState() async*{
    yield CartLoading();
    try{
      await Future<void>.delayed(Duration(seconds: 1));
      yield CartLoaded();
    }catch(_){}
  }
  Stream<CartState> _mapCartProductAddedToState(
      CartProductAdded event, CartState state
      ) async*{
    if(state is CartLoaded){
      try{
        yield CartLoaded(
          cart: Cart(
              products: List.from(state.cart.products)..add(event.product)
          ),
        );
      }
      catch(_){}
    }
  }
  Stream<CartState> _mapCartProductRemovedToState(
      CartProductRemoved event, CartState state
      ) async*{
    if(state is CartLoaded){
      try{
        yield CartLoaded(
          cart: Cart(
              products: List.from(state.cart.products)..remove(event.product)
          ),
        );
      }
      catch(_){}
    }
  }
}
