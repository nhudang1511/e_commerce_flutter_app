import 'package:flutter/material.dart';

class CustomeNavBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomeNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(Icons.home, color: Colors.white)),
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/cart');
              },
              icon: Icon(Icons.shopping_cart, color: Colors.white),),
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/person');
                },
                icon: Icon(Icons.person, color: Colors.white))
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}