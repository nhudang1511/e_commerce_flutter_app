import 'package:e_commerce/config/app_route.dart';
import 'package:e_commerce/repositories/auth/auth_repository.dart';
import 'package:e_commerce/repositories/category/category_repository.dart';
import 'package:e_commerce/repositories/checkout/checkout_repository.dart';
import 'package:e_commerce/repositories/product/product_repository.dart';
import 'package:e_commerce/repositories/user/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'config/theme.dart';
import 'cubits/login/login_cubit.dart';
import 'screen/screen.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero To Unicorn',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                authRepository: context.read<AuthRepository>(),
                userRepository: context.read<UserRepository>(),
              ),
            ),
            BlocProvider(
              create: (_) => CartBloc()..add(LoadCart()),
            ),
            BlocProvider(
              create: (context) => CheckoutBloc(
                cartBloc: context.read<CartBloc>(),
                checkoutRepository: CheckoutRepository(),
              ),
            ),
            BlocProvider(
              create: (_) => CategoryBloc(
                categoryRepository: CategoryRepository(),
              )..add(
                LoadCategories(),
              ),
            ),
            BlocProvider(
              create: (_) => ProductBloc(
                productRepository: ProductRepository(),
              )..add(LoadProducts()),
            ),
            BlocProvider(
              create: (_) => WishlistBloc(
              )..add(LoadWishlist()),
            ),
            BlocProvider(
              create: (context) => LoginCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Zero To Unicorn',
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
          ),
        ),
      ),
    );
  }
}



