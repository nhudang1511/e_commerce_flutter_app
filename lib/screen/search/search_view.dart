import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/search/search_cubit.dart';
import '../../models/models.dart';
import '../../widget/widgets.dart';

class SearchScreen extends StatelessWidget {

  const SearchScreen({super.key});
  static const String routeName = '/search';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => const SearchScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child:  const Scaffold(
        appBar: CustomAppBar(title: 'Search'),
        bottomNavigationBar: CustomeNavBar(),
        body: SearchBody(),
      ),
    );
  }
}
class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchCubit>(context);
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                cubit.search(query);
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter a search term',
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, List<DocumentSnapshot>>(
              builder: (context, snapshot) {
                if (snapshot.isEmpty) {
                  return const Center(child: Text('No results'));
                }

                return ListView.builder(
                  itemCount: snapshot.length,
                  itemBuilder: (context, index) {
                    final data = snapshot[index].data() as Map<String, dynamic>;
                    final product = Product(
                        name: data['name'], category: data['category'],
                        imageUrl: data['imageUrl'], price: data['price'],
                        isRecommended: data['isRecommended'], isPopular: data['isPopular']
                    );
                    return InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/product', arguments: product);
                      },
                      child: ListTile(
                        leading: product.imageUrl != null ? Image.network(
                          product.imageUrl,
                          width: 50, // Set the desired width
                          height: 50, // Set the desired height
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ) : SizedBox.shrink(),
                        title: Text(product.name),
                        subtitle: Column(
                          children: [
                            Text(product.category),
                            Text(product.price.toString())
                          ],
                        ),
                        // Customize how you display the search results
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
  }
}


