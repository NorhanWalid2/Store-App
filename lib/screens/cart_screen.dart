import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_card.dart'; // Import if needed

class CartScreen extends StatefulWidget {
  static String id = 'cart_screen';
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Add this to navigation if needed
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
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: cartProducts.isEmpty
          ? const Center(
              child: Text(
                'Nothing in cart yet',
                style: TextStyle(fontSize: 24),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  ProductModel product = cartProducts[index];
                  return ListTile(
                    leading:
                        Image.network(product.image, width: 50, height: 50),
                    title: Text(product.title),
                    subtitle: Text(r'$' '${product.price.toString()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        cartProducts.remove(product);
                        setState(() {}); // Update UI when removed
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
