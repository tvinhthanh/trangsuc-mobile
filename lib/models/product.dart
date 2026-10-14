class ProductModel {
  final String name;
  final String image;
  final double price;
  final double rating;
  final String type;      // ← Giờ là "ring", "bracelet", ...
  final String category;  // ← Giờ là "fashion", "wedding", ...

  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.type,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      type: json['type'] ?? '',       // loại sản phẩm
      category: json['category'] ?? '' // dịp sử dụng
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'rating': rating,
      'type': type,
      'category': category,
    };
  }
}
