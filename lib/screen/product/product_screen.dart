import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/models/models.dart';
import 'package:flutter/material.dart';

import '../../widget/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => ProductScreen(product: product));
  }
  final Product product;
  const ProductScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.share, color: Colors.white,)),
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.favorite, color: Colors.white,)),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: (){},
                  child: Text('ADD TO CART', style: Theme.of(context).textTheme.headline3!),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height),
              items: [HeroCarouselCard(product: product)]
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28.0
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  margin: const EdgeInsets.all(5.0),
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.name, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
                        Text('${product.price}', style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white) )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Product Information', style: Theme.of(context).textTheme.headline3),
              children: [
                ListTile(
                  title: Text('At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Delivery Information', style: Theme.of(context).textTheme.headline3),
              children: [
                ListTile(
                  title: Text('At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}
