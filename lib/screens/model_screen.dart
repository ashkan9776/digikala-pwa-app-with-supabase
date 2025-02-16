import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/model_controller.dart';
import '../models/brands.dart';

class ModelScreen extends StatelessWidget {
  final ModelController modelController = Get.put(ModelController());

  ModelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Brand brand = Get.arguments; // دریافت برند انتخاب‌شده

    // وقتی وارد صفحه شد، مدل‌های مرتبط با برند را بگیر
    modelController.fetchModels(brand.id);

    return Scaffold(
      appBar: AppBar(title: Text("📱 مدل‌های ${brand.name}")),
      body: Obx(() {
        if (modelController.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // لودینگ
        }

        if (modelController.models.isEmpty) {
          return const Center(child: Text("مدلی یافت نشد!"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // دو ستون
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: modelController.models.length,
          itemBuilder: (context, index) {
            final model = modelController.models[index];

            return GestureDetector(
              onTap: () {
                // رفتن به صفحه جزئیات مدل
                Get.toNamed('/model-details', arguments: model);
              },
              child: Column(
                children: [
                  Text(model.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ClipOval(
                    child: Image.network(
                      model.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${model.price} تومان',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
