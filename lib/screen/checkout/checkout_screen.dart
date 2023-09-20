import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../models/payment_menthod_model.dart';
import '../../widget/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});
  static const String routeName = '/checkout';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const CheckoutScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
                if(state is CheckoutLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is CheckoutLoaded){
                  if(Platform.isIOS){
                    switch(state.paymentMethod){
                      case PaymentMethod.apple_pay:
                        return ApplePay(
                            total: state.total!,
                            products: state.products!);
                      case PaymentMethod.credit_card:
                        return Container();
                      default:
                        return ApplePay(
                            total: state.total!,
                            products: state.products!);
                    }
                  }
                  if(Platform.isAndroid){
                    switch(state.paymentMethod){
                      case PaymentMethod.google_pay:
                        return GooglePay(
                          products: state.products!,
                          total: state.total!,
                        );
                      case PaymentMethod.credit_card:
                        return Container(
                          child: Text(
                              'Pay with Credit Card',
                            style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),
                          ),
                        );
                      default:
                        return GooglePay(
                          products: state.products!,
                          total: state.total!,
                        );
                    }
                  }
                  else{
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: (){
                        context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                        Navigator.pushNamed(context, '/payment');
                      },
                      child: Text('ORDER NOW', style: Theme.of(context).textTheme.headline3!),
                    );
                  }
                }
                else{
                  return const Text('Something went wrong');
                }},
              )
            ],
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
          if(state is CheckoutLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is CheckoutLoaded){
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CUSTOMER INFORMATION',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(email: value));
                  }, context, 'Email'),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(fullName: value));
                  }, context, 'Full Name'),
                  Text('DELIVERY INFORMATION',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(address: value));
                  }, context, 'Address'),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(city: value));
                  }, context, 'City'),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(country: value));
                  }, context, 'Country'),
                  _buildTextFormField((value){
                    context.read<CheckoutBloc>().add(UpdateCheckout(zipCode: value));
                  }, context, 'Zip Code'),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, '/payment');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('SELECT A PAYMENT METHOD', style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white)),
                        Icon(Icons.navigate_next, color: Colors.white,)
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('ORDER SUMMERY',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const OrderSummery()
                ],
              ),
            );
          }
          else{
            return const Text('Something went wrong');
          }
        },
        ),
      ),
    );
  }

  Padding _buildTextFormField(
      Function(String)? onChanged,
      BuildContext context,
      String labelText){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 75,
            child: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1),),
          Expanded(child: TextFormField(
            onChanged: onChanged,
            decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                )
            ),
          )
          )
        ],
      ),
    );
  }
}







