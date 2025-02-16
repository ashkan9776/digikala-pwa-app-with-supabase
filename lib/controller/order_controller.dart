import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController extends GetxController {
  final supabase = Supabase.instance.client;

  var orders = <Map<String, dynamic>>[].obs; // لیست سفارشات
  var isLoading = false.obs; // وضعیت لودینگ

  /// **📌 ثبت سفارش در دیتابیس**
  Future<void> submitOrder(List<Map<String, dynamic>> cartItems) async {
    try {
      isLoading.value = true;

      // بررسی اینکه آیا آیتم‌ها شامل تصویر و نام هستند
      final productImageUrl =
          cartItems.isNotEmpty ? cartItems[0]['image_url'] : '';
      final productName =
          cartItems.isNotEmpty ? cartItems[0]['name'] : ''; // نام محصول

      final order = {
        'user_id':
            supabase.auth.currentUser?.id, // ثبت سفارش برای کاربر لاگین‌شده
        'items': cartItems,
        'total_price': cartItems.fold(
            0.0, (sum, item) => sum + double.parse(item['price'].toString())),
        'created_at': DateTime.now().toIso8601String(),
        'product_image_url': productImageUrl, // ذخیره URL تصویر محصول
        'product_name': productName, // ذخیره نام محصول
      };

      // اصلاح درخواست ثبت سفارش
      final response = await supabase.from('orders').insert([order]).select();

      if (response.isEmpty) {
        throw Exception("مشکلی در ثبت سفارش رخ داد.");
      }

      Get.snackbar("✅ موفق!", "سفارش شما با موفقیت ثبت شد!");
      fetchOrders(); // بعد از ثبت سفارش، لیست سفارشات را به‌روز کن
    } catch (e) {
      print("❌ خطا در ثبت سفارش: $e");
      Get.snackbar("خطا", "مشکلی در ثبت سفارش به وجود آمد.");
    } finally {
      isLoading.value = false;
    }
  }

  /// **📌 دریافت لیست سفارشات از دیتابیس**
  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      final userId = supabase.auth.currentUser?.id;

      // اصلاح درخواست دریافت سفارشات بدون execute()
      final response = await supabase
          .from('orders')
          .select('*')
          .eq('user_id', userId!)
          .order('created_at', ascending: false);

      orders.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("❌ خطا در دریافت سفارشات: $e");
      Get.snackbar("خطا", "مشکلی در دریافت سفارشات پیش آمد.");
    } finally {
      isLoading.value = false;
    }
  }

  // تغییر وضعیت سفارش
  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await supabase
          .from('orders')
          .update({'status': status})
          .eq('id', orderId)
          .order('created_at', ascending: false);

      if (response.error != null) {
        throw response.error!;
      }

      // بروزرسانی لیست سفارشات پس از تغییر وضعیت
      fetchOrders();
    } catch (e) {
      print("❌ خطا در به‌روزرسانی وضعیت سفارش: $e");
    }
  }
}
