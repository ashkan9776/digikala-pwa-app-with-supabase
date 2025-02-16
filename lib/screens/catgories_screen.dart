import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/category_controller.dart';
import 'product_by_brand_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("دسته‌بندی‌ها")),
      body: Row(
        children: [
          // 📌 ستون سمت چپ: لیست دسته‌بندی‌ها
          Expanded(
            flex: 2,
            child: Obx(() {
              return ListView.builder(
                itemCount: categoryController.categories.length,
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];

                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        category['name'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                    minVerticalPadding: 1,
                    subtitle: CircleAvatar(
                        radius: 15,
                        child: Image.network(category['image_url'])),
                    onTap: () {
                      final categoryId = category['id'].toString();
                      categoryController.selectCategory(categoryId);
                    },
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    selectedColor: Colors.transparent,
                  );
                },
              );
            }),
          ),

          // 📌 ستون سمت راست: نمایش برندهای مربوطه
          Expanded(
            flex: 3,
            child: Obx(() {
              return categoryController.selectedCategoryId.value == "0"
                  ? const Center(child: Text("یک دسته‌بندی را انتخاب کنید"))
                  : ListView.builder(
                      itemCount: categoryController.brands.length,
                      itemBuilder: (context, index) {
                        final brand = categoryController.brands[index];
                        return ListTile(
                          title: Text(brand['name']),
                          leading: CircleAvatar(
                              radius: 21,
                              child: Image.network(brand['image_url'])),
                          onTap: () {
                            // 📌 انتقال به صفحه لیست محصولات برند
                            Get.to(() => ProductsByBrandScreen(
                                  brandId: brand['id'].toString(),
                                  brandName: brand['name'],
                                ));
                          },
                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
