import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/model.dart';
import '../models/cart_item.dart'; // وارد کردن مدل CartItem
import '../controller/cart_controller.dart'; // وارد کردن کنترلر سبد خرید

class ModelDetailsScreen extends StatelessWidget {
  const ModelDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Model model = Get.arguments; // دریافت مدل انتخاب‌شده
    final CartController cartController = Get.find(); // دریافت کنترلر سبد خرید

    return Scaffold(
      appBar: AppBar(title: Text(model.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // نمایش تصویر مدل
            Center(
              child: ClipOval(
                child: Image.network(
                  model.imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // نمایش نام مدل
            Text(
              model.name,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),

            // نمایش قیمت مدل
            Text(
              'قیمت: ${model.price} تومان',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),

            // نمایش ویژگی‌ها (در صورتی که اضافه کنی)
            const Text(
              'ویژگی‌ها:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // فرض می‌کنیم ویژگی‌ها در فیلد خاصی در جدول ذخیره شده است
            // اگر ویژگی‌ها اضافه کردی، آن‌ها را اینجا نمایش بده
            Text(
              'مثلاً ویژگی‌هایی مثل RAM, Camera, etc...',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // دکمه افزودن به سبد خرید
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // تبدیل مدل به CartItem
                  CartItem cartItem = CartItem(
                    id: model.id,
                    name: model.name,
                    price: model.price.toDouble(),
                    imageUrl: model.imageUrl,
                    quantity: 1, // تعداد اولیه
                  );

                  // افزودن مدل به سبد خرید
                  cartController.addToCart(cartItem as Map<String, dynamic>);

                  // نمایش پیام تایید
                  Get.snackbar('موفقیت', 'مدل به سبد خرید اضافه شد.');
                },
                child: const Text('افزودن به سبد خرید'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
