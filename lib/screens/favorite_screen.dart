import 'package:flutter/material.dart';
import 'package:store_app/widgets/custom_card.dart';

class FavoritesScreen extends StatefulWidget {
  static String id = 'favourite';
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context)
                .openDrawer(); // Open the drawer when menu icon is pressed
          },
        ),
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 90),
        child: favoriteProducts.isEmpty
            ? const Center(
                child: Text(
                  'No favorites yet',
                  style: TextStyle(fontSize: 24),
                ),
              )
            : GridView.builder(
                clipBehavior: Clip.none,
                itemCount: favoriteProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 100,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(
                    product: favoriteProducts[index],
                  );
                },
              ),
      ),
    );
  }
}
