import 'package:e_commerce/blocs/cart/cart_event.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart/cart_state.dart';
import '../../widget/widgets.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  const OrderConfirmationScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const OrderConfirmationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Confirmation'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                if(state is CartLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is CartLoaded){
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: (){
                      context
                          .read<CartBloc>()
                          .add(RemoveAllProduct(state.cart.products));
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('COUNTINUE SHOPPING', style: Theme.of(context).textTheme.headline3!),
                  );
                }
                else{
                  return const Text('Something went wrong');
                }},
              )
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 300,
                ),
                Positioned(
                    left: (MediaQuery.of(context).size.width - 100)/2,
                    top: 125,
                    child: SvgPicture.asset('assets/svgs/garlands.svg')),
                Positioned(
                    top: 250,
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Text('Your order is completed',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white))
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Thanh you for purchasing on Zero To Unicorn',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            OrderSummery(),
            SizedBox(height: 20),
            Text(
              'ORDER DETAILS',
              style: Theme.of(context).textTheme.headline5,
            ),
            Divider(thickness: 2),
            SizedBox(height: 5),
            ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              children: [
                OrderSummaryProductCard(product: Product.products[0], quantity: 2 ,),
                OrderSummaryProductCard(product: Product.products[1], quantity: 2 ,)
              ],
            )
          ],
        ),
      ),
    );
  }
}


