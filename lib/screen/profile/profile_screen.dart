import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_state.dart';
import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_state.dart';
import '../../models/models.dart';
import '../../widget/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const ProfileScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are not log in', style: Theme.of(context).textTheme.headline4,),
            SizedBox(
              width: (MediaQuery.of(context).size.width)/2,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Log in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                ),
              ),
            ),
            SizedBox(
              width: (MediaQuery.of(context).size.width)/2,
                child: ElevatedButton(onPressed: (){
                  Navigator.pushNamed(context, '/signup');
                }, child: Text('Sign up')))
          ],
        ),
      ),
    );
  }
}







