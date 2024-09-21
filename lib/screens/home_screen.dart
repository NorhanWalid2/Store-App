import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_products.dart';
import 'package:store_app/widgets/custom_card.dart';

// The Home page content
class HomeContentScreen extends StatefulWidget {
  static String id = 'homepage';

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  Future<List<ProductModel>>? _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = AllProductsService().getAllProduct();
  }

  void _refreshProducts() {
    setState(() {
      _productsFuture = AllProductsService().getAllProduct();
      print('updare is : $_productsFuture');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'New Trend',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            color: Colors.blue,
            Icons.menu,
            size: 35,
          ),
          onPressed: () {
            Scaffold.of(context)
                .openDrawer(); // Open the drawer when menu icon is pressed
          },
        ),
        actions: const [
          Icon(
            color: Colors.blue,
            Icons.shopping_cart,
            size: 35,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 90),
        child: FutureBuilder<List<ProductModel>>(
          future: _productsFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              List<ProductModel> products = snapshot.data!;
              return GridView.builder(
                itemCount: products.length - 1,
                clipBehavior: Clip.none,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 100,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(
                    product: products[index],

                    //onUpdate: _refreshProducts,
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
