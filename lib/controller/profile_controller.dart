import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController {
  var imageUrl = "".obs; // لینک تصویر پروفایل
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // مقداردهی اولیه فیلدها
    nameController.text = "صدف کاربر";
    emailController.text = "user@example.com";
  }

  // انتخاب تصویر پروفایل
 

  // ذخیره تغییرات
  void updateProfile() {
    Get.snackbar("✅ موفق!", "تغییرات با موفقیت ذخیره شد.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white);
  }
}
