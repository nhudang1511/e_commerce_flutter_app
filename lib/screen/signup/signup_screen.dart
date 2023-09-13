import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_state.dart';
import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_state.dart';
import '../../models/models.dart';
import '../../widget/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String routeName = '/signup';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SignupScreen());
  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController zipCodeController = TextEditingController();
    final TextEditingController passWordController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Sign up'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTextFormField(emailController, context, 'Email'),
            _buildTextFormField(fullNameController, context, 'Full Name'),
            _buildTextFormField(countryController, context, 'Country'),
            _buildTextFormField(cityController, context, 'City'),
            _buildTextFormField(addressController, context, 'Address'),
            _buildTextFormField(zipCodeController, context, 'Zip Code'),
            _buildTextFormField(passWordController, context, 'PassWord'),
            SizedBox(
              width: (MediaQuery.of(context).size.width)/2,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Sign up'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  Padding _buildTextFormField(
      TextEditingController onChanged,
      BuildContext context,
      String labelText){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          SizedBox(width: 75,
            child: Text(
                labelText,
                style: Theme.of(context).textTheme.bodyText1),),
          Expanded(child: TextFormField(
            //onChanged: onChanged,
            controller: onChanged,
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







