class ProductModel {
  final int id;
  String title;
  dynamic price;
  String description;
  final String category;
  String image;
  final RatingModel rating;
  bool isFavourit = false;
  bool isAdded = false;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    // Ensure jsonData and fields are checked
    return ProductModel(
      id: jsonData['id'] ?? 0,
      title: jsonData['title'] ?? '',
      price: double.tryParse(jsonData['price'].toString()) ?? 0.0,
      description: jsonData['description'] ?? '',
      category: jsonData['category'] ?? '',
      image: jsonData['image'] ?? '',
      rating: jsonData['rating'] != null
          ? RatingModel.fromJson(jsonData['rating'])
          : RatingModel(rate: 0.0, count: 0),
    );
  }
}

class RatingModel {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> jsonData) {
    // Ensure jsonData and fields are checked
    return RatingModel(
      rate: (jsonData['rate'] is int)
          ? (jsonData['rate'] as int).toDouble()
          : (jsonData['rate'] ?? 0.0).toDouble(),
      count: jsonData['count'] ?? 0,
    );
  }
}
