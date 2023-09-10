import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_state.dart';
import '../../models/models.dart';
import '../../widget/widgets.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  const CartScreen({super.key});

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CartScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      bottomNavigationBar:  BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: (){},
                child: Text('GO TO CHECKOUT', style: Theme.of(context).textTheme.headline3!),
              )
            ],
          ),
        ),
      ),
      body: 
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if(state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is CartLoaded){
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.cart.feeDeliveryString,
                              style: Theme.of(context).textTheme.headline5,),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/');
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: const RoundedRectangleBorder(),
                                    elevation: 0
                                ),
                                child: Text('Add More Items',
                                  style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Colors.white
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 350,
                          child: ListView.builder(
                              itemCount: state.cart.productQuantity(state.cart.products).keys.length,
                              itemBuilder: (context, index){
                                return CartProductCard(
                                  product: state.cart.productQuantity(state.cart.products).keys.elementAt(index),
                                  quantity: state.cart.productQuantity(state.cart.products).values.elementAt(index),
                                );
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(thickness: 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 10
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('SUBTOTAL', style: Theme.of(context).textTheme.headline5),
                                  Text('\$${state.cart.subtotalString}', style: Theme.of(context).textTheme.headline5)
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('DELIVERY FEE', style: Theme.of(context).textTheme.headline5),
                                  Text('\$${state.cart.deliveryFeeString}', style: Theme.of(context).textTheme.headline5)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(50)
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5.0),
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.black
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('TOTAL', style: Theme.of(context).textTheme.headline5!.copyWith(
                                        color: Colors.white
                                    )),
                                    Text('\$${state.cart.totalString}', style: Theme.of(context).textTheme.headline5!.copyWith(
                                        color: Colors.white
                                    ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            else{
              return const Text('Something went wrong');
            }
  },
)
    );
  }
}


