import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/category/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {

  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()){
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }
  void _onLoadCategories(event, Emitter<CategoryState> emit) async{
    _categorySubscription?.cancel();
    _categorySubscription =
        _categoryRepository
            .getAllCategories()
            .listen((event) => add(UpdateCategories(event)));
  }
  void _onUpdateCategories(event, Emitter<CategoryState> emit) async{
    emit(CategoryLoaded(categories: event.categories));
  }
  // @override
  // Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
  //   if (event is LoadCategories) {
  //     yield* _mapLoadCategoriesToState();
  //   }
  //   if (event is UpdateCategories){
  //     yield* _mapUpdateCategoriesToState(event);
  //   }
  // }
  // Stream<CategoryState> _mapLoadCategoriesToState() async*{
  //   _categorySubscription?.cancel();
  //   _categorySubscription =
  //       _categoryRepository
  //           .getAllCategories()
  //           .listen((event) => add(UpdateCategories(event)));
  // }
  // Stream<CategoryState> _mapUpdateCategoriesToState(UpdateCategories event) async*{
  //   yield CategoryLoaded(categories: event.categories);
  // }
}
