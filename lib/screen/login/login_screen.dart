import 'package:flutter/material.dart';
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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passWordController = TextEditingController();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextFormField(emailController, context, 'Email'),
            _buildTextFormField(passWordController, context, 'PassWord'),
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
                  Navigator.pushNamed(context, '/');
                }, child: Text('Sign In With Google')))
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







