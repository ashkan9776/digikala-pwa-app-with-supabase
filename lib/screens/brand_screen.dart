import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/brand_controller.dart';
import '../models/category.dart';

class BrandScreen extends StatelessWidget {
  final BrandController brandController = Get.put(BrandController());

  BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Category category = Get.arguments; // دریافت دسته‌بندی انتخاب‌شده

    // وقتی وارد صفحه شد، برندهای مرتبط را بگیر
    brandController.fetchBrands(category.id);

    return Scaffold(
      appBar: AppBar(title: Text("📢 برندهای ${category.name}")),
      body: Obx(() {
        if (brandController.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // لودینگ
        }

        if (brandController.brands.isEmpty) {
          return const Center(child: Text("برندی یافت نشد!"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // دو ستون
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: brandController.brands.length,
          itemBuilder: (context, index) {
            final brand = brandController.brands[index];

            return GestureDetector(
              onTap: () {
                Get.toNamed('/models', arguments: brand);
              },
              child: Column(
                children: [
                  Text(brand.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ClipOval(
                    child: Image.network(
                      brand.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
