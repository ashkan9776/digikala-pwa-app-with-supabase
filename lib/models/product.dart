class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'], // تبدیل به double
      imageUrl: json['image_url'] ?? '',
    );
  }
}
