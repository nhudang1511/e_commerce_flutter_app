import 'package:e_commerce/blocs/checkout/checkout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/checkout/checkout_bloc.dart';
import '../../blocs/checkout/checkout_state.dart';
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
    // final TextEditingController emailController = TextEditingController();
    // final TextEditingController nameController = TextEditingController();
    // final TextEditingController addressController = TextEditingController();
    // final TextEditingController cityController = TextEditingController();
    // final TextEditingController countryController = TextEditingController();
    // final TextEditingController zipCodeController = TextEditingController();
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
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: (){
                      context.read<CheckoutBloc>().add(ConfirmCheckout(checkout: state.checkout));
                      Navigator.pushNamed(context, '/order-confirmation');
                    },
                    child: Text('ORDER NOW', style: Theme.of(context).textTheme.headline3!),
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
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
          if(state is CheckoutLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is CheckoutLoaded){
            return Column(
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
                Text('ORDER SUMMERY',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const OrderSummery()
              ],
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







