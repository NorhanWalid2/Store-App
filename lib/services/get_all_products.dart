//import 'dart:convert';

import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

//import 'package:http/http.dart' as http;
List<ProductModel> productList = [];

class AllProductsService {
  Future<List<ProductModel>> getAllProduct() async {
    List<dynamic> data =
        await Api().get(url: 'https://fakestoreapi.com/products');
    print('API Response: $data');

    for (var i = 0; i < data.length; i++) {
      productList.add(
        ProductModel.fromJson(data[i]),
      );
    }
    print(productList);
    return productList;
  }
}
