class Model {
  String id;
  String name;
  String imageUrl;
  int price;
  String? description;

  Model({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.description,
  });

  // تبدیل داده‌ها از JSON به مدل
  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'], // فرض می‌کنیم که نام فیلد تصویر این باشد
      price: json['price'],
      description: json['description'],
    );
  }
}
