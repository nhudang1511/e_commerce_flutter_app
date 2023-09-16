import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/login/login_cubit.dart';
import '../../cubits/login/login_state.dart';
import '../../widget/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const LoginScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _EmailInput(),
            _PasswordInput(),
            SizedBox(
              width: (MediaQuery.of(context).size.width)/2,
              child: ElevatedButton(
                onPressed: (){
                  context.read<LoginCubit>().logInWithCredentials();
                  Navigator.pushNamed(context, '/');
                },
                child: Text('Log in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black),
                  ),
                ),
                SizedBox(
                    width: (MediaQuery.of(context).size.width)/2,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, '/');
                    }, child: Text('Sign In With Google')))
              ],
            ),
        ),
      );
  }
}
class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onChanged: (email) {
              context.read<LoginCubit>().emailChanged(email);
            },
            decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:  Theme.of(context).textTheme.bodyText1,
                contentPadding: EdgeInsets.only(left: 10)
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            onChanged: (password) {
              context.read<LoginCubit>().passwordChanged(password);
            },
            decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:  Theme.of(context).textTheme.bodyText1,
                contentPadding: EdgeInsets.only(left: 10)
            ),
            obscureText: true,
          ),
        );
      },
    );
  }
}





