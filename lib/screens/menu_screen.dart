import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';

import 'package:store_app/services/categories.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
    return ListView(
      padding: EdgeInsets.zero,
      children: const <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/image.png'),
                // If you want to use a network image, use Image.network()
                // backgroundImage: NetworkImage('https://example.com/profile.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome, User!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('User Account Management'),
        ),
        ListTile(
          leading: Icon(Icons.support),
          title: Text('Support & Assistance'),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('App Information'),
        ),
        ListTile(
          leading: Icon(Icons.local_offer),
          title: Text('Promotions & Offers'),
        ),
        ListTile(
          leading: Icon(Icons.connect_without_contact),
          title: Text('Social Media and Community'),
        ),
        ListTile(
          leading: Icon(Icons.emoji_events),
          title: Text('Loyalty Program'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    );
  }
}
