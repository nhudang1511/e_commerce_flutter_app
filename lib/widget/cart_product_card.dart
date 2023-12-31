import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';
import '../models/product_model.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;

  const CartProductCard({
    required this.product,
    required this.quantity,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            height: 80,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: Theme.of(context).textTheme.headline5),
                Text('\$${product.price}', style: Theme.of(context).textTheme.headline6,)
              ],
            ),
          ),
          SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(onPressed: (){
                    context
                        .read<CartBloc>()
                        .add(RemoveProduct(product));
                    }, icon: const Icon(Icons.remove_circle)),
                  Text('$quantity', style: Theme.of(context).textTheme.headline4),
                  IconButton(onPressed: (){
                    context
                        .read<CartBloc>()
                        .add(AddProduct(product));
                  }, icon: const Icon(Icons.add_circle)),
                ],
              );
              },
)
        ],
      ),
    );
  }
}