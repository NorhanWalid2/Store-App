import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/categories.dart';
import 'package:store_app/widgets/custom_text_field.dart';

class SearchScreen extends StatefulWidget {
  static String id = 'search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> _products = [];
  bool _isLoading = false;

  Future<void> searchCategory(String categoryName) async {
    setState(() {
      _isLoading = true; // Show loading indicator while fetching data
    });

    try {
      _products =
          await CategoriesService().getCategory(categoryName: categoryName);
    } catch (e) {
      // Handle error here
      print("Error fetching products: $e");
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator once done
      });
    }
  }

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
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              onsubmit: (data) {
                searchCategory(data);
              },
              hint: 'Search category',
              labeltextt: 'Search',
              obscure: false,
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator()) // Loading indicator
                : _products.isEmpty
                    ? const Center(child: Text('No products found'))
                    : Expanded(
                        child: GridView.builder(
                          itemCount: _products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            final product = _products[index];
                            return Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    product.image,
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      product.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '\$${product.price.toString()}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
