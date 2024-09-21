import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';
//import 'package:http/http.dart' as http;

class AddProductsService {
  Future<ProductModel> addProduct({
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    Map<String, dynamic> data =
        await Api().post(url: 'https://fakestoreapi.com/products', body: {
      'title': title,
      'price': price,
      'description': desc,
      'image': image, //i.pravatar.cc
      'category': category
    });
    return ProductModel.fromJson(data);
  }
}
