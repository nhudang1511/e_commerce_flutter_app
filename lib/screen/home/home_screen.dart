import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widget/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const HomeScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Zero To Unicorn'),
      bottomNavigationBar: const CustomeNavBar(),
      body:  CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.5,
          viewportFraction: 0.9,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height
        ),
        items: Category.categories.map((category) =>
            HeroCarouselCard(category: category)).toList(),
      ),
    );
  }
}


