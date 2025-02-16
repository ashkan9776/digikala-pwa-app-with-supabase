import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digikala_pwa/controller/product_controller.dart';

import '../controller/cart_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductController productController = Get.find<ProductController>();
  final CartController cartController =
      Get.put(CartController()); // دسترسی به کنترلر سبد خرید
  late String productId;

  @override
  void initState() {
    super.initState();
    productId = Get.arguments; // دریافت `id` محصول
    Future.delayed(Duration.zero, () {
      // ✅ تاخیر برای جلوگیری از خطای `setState`
      productController.fetchProductDetails(productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("جزئیات محصول")),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = productController.selectedProduct.value;
        if (product == null) {
          return const Center(child: Text("محصولی یافت نشد"));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Image.network(
                    product['image_url'] ?? '',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product['name'] ?? 'نام محصول',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${product['price']} تومان",
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 16),
                const Text(
                  "توضیحات محصول:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 8),
                Text(
                  product['description'] ??
                      'توضیحی برای این محصول ثبت نشده است.',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // افزودن محصول به سبد خرید
                      cartController.addToCart(product);
                      Get.snackbar(
                          "محصول اضافه شد", "محصول به سبد خرید شما اضافه شد");
                    },
                    child: const Text("افزودن به سبد خرید"),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
