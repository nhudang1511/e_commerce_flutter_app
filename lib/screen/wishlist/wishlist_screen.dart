
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/wishlist/wishlist_bloc.dart';
import '../../blocs/wishlist/wishlist_state.dart';
import '../../models/models.dart';
import '../../widget/widgets.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => WishlistScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'WishList'),
      bottomNavigationBar: CustomeNavBar(),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if(state is WishListLoading){
            return Center(child: CircularProgressIndicator());
          }
          if(state is WishListLoaded){
            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16.0
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 2.2),
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: ProductCard(
                    product: state.wishlist.products[index],
                    widthFactor: 1.1,
                    leftPosition: 100,
                    isWishlist: true,
                  ),
                );
              },
              itemCount: state.wishlist.products.length,
            );
          }
          else{
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
