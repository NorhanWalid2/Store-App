import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/screens/update_screen.dart';
import 'package:store_app/services/get_all_products.dart';

List<ProductModel> favoriteProducts = [];
List<ProductModel> cartProducts = [];

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  CustomCard({super.key, required this.product, this.onUpdate});
  ProductModel product;
  final Function? onUpdate;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isFavorite = false;
  bool isAddedToCart = false;

  @override
  void initState() {
    super.initState();
    isFavorite = favoriteProducts.contains(widget.product);
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        favoriteProducts.remove(widget.product);
      } else {
        favoriteProducts.add(widget.product);
      }
      productList[widget.product.id].isFavourit = !isFavorite;
    });
  }

  void toggleAddToCart() {
    setState(() {
      if (isAddedToCart) {
        cartProducts.remove(widget.product);
      } else {
        cartProducts.add(widget.product);
      }
      productList[widget.product.id].isAdded = !isAddedToCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = productList[widget.product.id].isFavourit;
    isAddedToCart = productList[widget.product.id].isAdded;
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, UpdateScreen.id,
            arguments: widget.product);
        setState(() {});
        // Call the update function when returning
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 5, // Blur radius
                  offset: const Offset(0, 3), // Offset
                ),
              ],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    widget.product.title,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    children: [
                      Text(r'$' '${widget.product.price}'),
                      const Spacer(
                        flex: 1,
                      ),
                      GestureDetector(
                        child: Icon(
                          isAddedToCart ? Icons.check : Icons.add,
                          color: isAddedToCart ? Colors.green : Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            if (isAddedToCart) {
                              cartProducts.remove(widget.product);
                            } else {
                              cartProducts.add(widget.product);
                            }
                            productList[widget.product.id].isAdded =
                                !isAddedToCart;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            if (isFavorite) {
                              favoriteProducts.remove(widget.product);
                              widget.product.isFavourit = !isFavorite;
                            } else {
                              favoriteProducts.add(widget.product);
                            }
                            productList[widget.product.id].isFavourit =
                                !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 60,
            top: -70,
            child: Image.network(
              widget.product.image,
              height: 150,
              width: 90,
            ),
          ),
        ],
      ),
    );
  }
}
