import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/services/get_all_category.dart';
import 'package:store_app/services/get_all_products.dart';
import 'package:store_app/services/update_product.dart';
import 'package:store_app/widgets/custom_button.dart';
import 'package:store_app/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key});
  static String id = ' update product';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String? productName, description, image;

  String? price;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Update product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                CustomTextField(
                  onchange: (data) {
                    productName = data;
                  },
                  hint: 'Product Name',
                  labeltextt: 'product name',
                  obscure: false,
                  icon: const Icon(Icons.production_quantity_limits),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onchange: (data) {
                    description = data;
                  },
                  hint: 'Description',
                  labeltextt: 'description',
                  obscure: false,
                  icon: Icon(Icons.description),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  inputType: TextInputType.number,
                  onchange: (data) {
                    price = data;
                  },
                  hint: 'Price',
                  labeltextt: 'price',
                  obscure: false,
                  icon: Icon(Icons.price_change),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onchange: (data) {
                    image = data;
                  },
                  hint: 'Image',
                  labeltextt: 'Image',
                  obscure: false,
                  icon: Icon(Icons.image),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomButton(
                  conText: 'Update',
                  ontap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await updateproduct(product);
                      List<ProductModel> NewList =
                          await AllProductsService().getAllProduct();
                      NewList[product.id].description = product.description;
                      NewList[product.id].price = product.price;
                      NewList[product.id].title = product.title;
                      NewList[product.id].image = product.image;
                      Navigator.pop(context);

                      print('succes');
                      print(getAllCategory());
                    } catch (e) {
                      // TODO
                      print(e.toString());
                    }
                    isLoading = false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ProductModel> updateproduct(ProductModel product) async {
    await UpdateProductService().UpdateProduct(
        title: productName == null ? product.title : productName!,
        price: price == null ? product.price.toString() : price!,
        desc: description == null ? product.description : description!,
        image: image == null ? product.image : image!,
        id: product.id,
        category: product.category);
    product.title = productName == null ? product.title : productName!;
    product.price = price == null ? product.price : price!;
    product.description =
        description == null ? product.description : description!;
    product.image = image == null ? product.image : image!;
    return product;
  }

  Future<void> getAllCategory() async {
    await AllCategoryService().getAllCategory();
  }
}
