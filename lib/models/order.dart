class Order {
  final int id;
  final String userId;
  final double totalPrice;
  final String createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      totalPrice: json['total_price'].toDouble(), // تبدیل به double
      createdAt: json['created_at'],
    );
  }
}
