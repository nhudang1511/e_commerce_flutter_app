import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../widget/widgets.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => CatalogScreen(category: category));
  }

  final Category category;

  const CatalogScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    //final List<Product> categoryProducts = Product.products.where((element) => element.category == category.name).toList();
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomeNavBar(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if(state is ProductLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is ProductLoaded){
            final List<Product> categoryProducts = state.products.where((element) {
              return element.category == category.name;
            }).toList();

            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.15),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ProductCard(
                    product: categoryProducts[index],
                    widthFactor: 2.2,
                  ),
                );
              },
              itemCount: categoryProducts.length,
            );
          }
          else{
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
