import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const CustomAppBar({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10
          ),
          child: Text( title,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.white)
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [IconButton(
          onPressed:(){
            Navigator.pushNamed(context, '/wishlist');
          },
          icon: const Icon(Icons.favorite))],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}


