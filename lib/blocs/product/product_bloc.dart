import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/models.dart';
import '../../repositories/product/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository= productRepository,
        super(ProductLoading()){
   on<LoadProducts>(_onLoadProducts);
   on<UpdateProducts>(_onUpdateProducts);
  }
  void _onLoadProducts(event, Emitter<ProductState> emit) async{
    _productSubscription?.cancel();
    _productSubscription =
        _productRepository
            .getAllProducts()
            .listen((event) => add(UpdateProducts(event)));
  }
  void _onUpdateProducts(event, Emitter<ProductState> emit) async{
    emit(ProductLoaded(products: event.products));
  }
  // @override
  // Stream<ProductState> mapEventToState(ProductEvent event) async* {
  //   if (event is LoadProducts) {
  //     yield* _mapLoadProductsToState();
  //   }
  //   if (event is UpdateProducts){
  //     yield* _mapUpdateProductsToState(event);
  //   }
  // }
  // Stream<ProductState> _mapLoadProductsToState() async*{
  //   _productSubscription?.cancel();
  //   _productSubscription =
  //       _productRepository
  //           .getAllProducts()
  //           .listen((event) => add(UpdateProducts(event)));
  // }
  // Stream<ProductState> _mapUpdateProductsToState(UpdateProducts event) async*{
  //   yield ProductLoaded(products: event.products);
  // }
}
