class Brand {
  final String id;
  final String name;
  final String imageUrl;

  Brand({required this.id, required this.name, required this.imageUrl});

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'].toString(),
      name: json['name'],
      imageUrl: json['image_url'] ?? '',
    );
  }
}
