import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digikala_pwa/controller/cart_controller.dart';
import 'package:digikala_pwa/controller/order_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("سبد خرید")),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (cartController.cartItems.isEmpty) {
                return const Center(child: Text("سبد خرید شما خالی است"));
              }

              return ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];

                  return ListTile(
                    leading: product['image_url'] != null
                        ? Image.network(product['image_url']!,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported, size: 50),
                    title: Text(product['name'] ?? "نام محصول نامشخص"),
                    subtitle: Text("${product['price'] ?? 0} تومان"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cartController.removeFromCart(product);
                      },
                    ),
                  );
                },
              );
            }),
          ),
          Obx(() => Text("مجموع: ${cartController.totalPrice.toInt()} تومان",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (cartController.cartItems.isNotEmpty) {
                await orderController.submitOrder(cartController.cartItems);
                cartController.clearCart();
              }
            },
            child: const Text("ثبت سفارش"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
