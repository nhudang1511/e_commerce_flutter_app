import 'package:e_commerce/widget/widgets.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;
  const ProductCarousel({
    required this.products,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0
          ),
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: ProductCard(product: products[index]),
            );
          }),
    );
  }
}
