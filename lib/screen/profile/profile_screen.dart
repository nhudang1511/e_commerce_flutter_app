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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CUSTOMER INFORMATION',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: 'Email',
                  initialValue: state.user.email,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(email: value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  title: 'Full Name',
                  initialValue: state.user.fullName,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(fullName: value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  title: 'Address',
                  initialValue: state.user.address,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(address: value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  title: 'City',
                  initialValue: state.user.city,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(city: value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  title: 'Country',
                  initialValue: state.user.country,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(country: value),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                CustomTextFormField(
                  title: 'ZIP Code',
                  initialValue: state.user.zipCode,
                  onChanged: (value) {
                    context.read<ProfileBloc>().add(
                      UpdateProfile(
                        user: state.user.copyWith(zipCode: value),
                      ),
                    );
                  },
                ),
                Expanded(child: Container()),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<AuthRepository>().signOut();
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(),
                      primary: Colors.black,
                      fixedSize: Size(200, 40),
                    ),
                    child: Text(
                      'Sign Out',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
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







