import 'package:flutter/material.dart';
import 'package:store_app/screens/cart_screen.dart';
import 'package:store_app/screens/favorite_screen.dart';
import 'package:store_app/screens/home_screen.dart';
import 'package:store_app/screens/menu_screen.dart';
import 'package:store_app/screens/search_screen.dart';
import 'package:store_app/screens/update_screen.dart';
//import 'package:store_app/screens/women_clothing.dart';

void main() {
  runApp(StoreApp());
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  int _selectedIndex = 0;

  // List of screens for each BottomNavigationBar item
  final List<Widget> _pages = [
    HomeContentScreen(), // The Home page content
    SearchScreen(), // Placeholder for search screen
    CartScreen(), // Placeholder for cart screen
    FavoritesScreen(), // Placeholder for favorites screen
    //MenuScreen(), // Placeholder for profile screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeContentScreen.id: (context) => HomeContentScreen(),
        UpdateScreen.id: (context) => UpdateScreen(),
        FavoritesScreen.id: (context) => FavoritesScreen(),
        UpdateScreen.id: (context) => UpdateScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        CartScreen.id: (context) => CartScreen(),
      },
      home: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 40,
                color: Colors.black,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 40,
                color: Colors.black,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 40,
                color: Colors.black,
              ),
              label: 'Favorites',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(
            //     Icons.menu,
            //     size: 40,
            //     color: Colors.black,
            //   ),
            //   label: 'Menu',
            // ),
          ],
        ),
        drawer: Drawer(
          child: MenuScreen(), // Set your menu screen here
        ),
        body: _pages[_selectedIndex], // Display the selected page
      ),
    );
  }
}
