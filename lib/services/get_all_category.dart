//import 'dart:convert';

//import 'package:http/http.dart' as http;
import 'package:store_app/helper/api.dart';

class AllCategoryService {
  Future<List<dynamic>> getAllCategory() async {
    List<dynamic> data =
        await Api().get(url: 'https://fakestoreapi.com/products/categories');
    print(data);
    return data;
  }
}
