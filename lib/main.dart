import 'package:e_commerce/blocs/wishlist/wishlist_event.dart';
import 'package:e_commerce/config/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/wishlist/wishlist_bloc.dart';
import 'config/theme.dart';
import 'screen/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>  WishlistBloc()..add(StartWishlist()))
      ],
      child: MaterialApp(
        title: 'Zero to Unicorn',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}



