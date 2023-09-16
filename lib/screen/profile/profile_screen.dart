import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/user/user_repository.dart';
import '../../widget/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = '/profile';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => BlocProvider<ProfileBloc>
          (create: (context) => ProfileBloc(
            authBloc:  BlocProvider.of<AuthBloc>(context),
            userRepository: context.read<UserRepository>())..add(
          LoadProfile(context.read<AuthBloc>().state.authUser),
        ),
          child: ProfileScreen(),
));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if(state is ProfileLoading){
          return Center(child: CircularProgressIndicator());
        }
        if(state is ProfileLoaded){
          return Center(
            child: SizedBox(
              width: (MediaQuery.of(context).size.width)/2,
              child: ElevatedButton(
                onPressed: (){
                  context.read<AuthRepository>().signOut();
                },
                child: Text('Sign out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,

                ),
              ),
            ),
          );
        }
        if(state is ProfileUnauthenticated){
          return Center(
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
                      context.read<AuthRepository>().signOut();
                    }, child: Text('Sign up')))
              ],
            ),
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







