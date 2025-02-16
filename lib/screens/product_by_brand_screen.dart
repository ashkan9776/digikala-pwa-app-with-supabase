import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digikala_pwa/controller/product_controller.dart';
import 'package:digikala_pwa/screens/product_details_screen.dart';

class ProductsByBrandScreen extends StatelessWidget {
  final String brandId;
  final String brandName;
  final ProductController productController = Get.put(ProductController());

  ProductsByBrandScreen(
      {super.key, required this.brandId, required this.brandName});

  @override
  Widget build(BuildContext context) {
    productController.fetchProductsByBrand(brandId);

    return Scaffold(
      appBar: AppBar(title: Text("محصولات $brandName")),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.products.isEmpty) {
          return const Center(child: Text("محصولی یافت نشد."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ تصویر محصول
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product['image_url'] ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 90),
                      ),
                    ),
                    const SizedBox(width: 12), // فاصله بین عکس و متن
                    // ✅ اطلاعات محصول
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? '',
                            maxLines: 1, // محدودیت به یک خط
                            overflow: TextOverflow
                                .ellipsis, // نمایش "..." در صورت طولانی بودن
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product['short_description'] ??
                                'توضیحات موجود نیست',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${product['price']} تومان",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  () => const ProductDetailsScreen(),
                                  arguments: product['id'],
                                );
                              },
                              child: const Text("مشاهده"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
