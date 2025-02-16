import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs; // لیست آیتم‌های سبد خرید

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
  }

  void removeFromCart(Map<String, dynamic> product) {
    cartItems.remove(product);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] as num));
  }
}
