import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/category_bloc.dart';
import '../../blocs/category/category_state.dart';
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
      body:  SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if(state is CategoryLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is CategoryLoaded){
                  return CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height
                    ),
                    items: state.categories.map((category) =>
                        HeroCarouselCard(category: category)).toList(),
                  );
                }
                else{
                  return const Text('Something went wrong');
                }
                },
            ),
            const SectionTitle(title: 'RECOMMENDED'),
            // ProductCard(product: Product.products[0]),
            //Product Carousel
            ProductCarousel(products: Product.products.where((element) => element.isRecommended).toList()),
            const SectionTitle(title: 'POPULAR'),
            ProductCarousel(products: Product.products.where((element) => element.isPopular).toList()),
          ],
        ),
      ),
    );
  }
}







