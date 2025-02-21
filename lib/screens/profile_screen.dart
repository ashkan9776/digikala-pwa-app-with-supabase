import 'package:digikala_pwa/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("پروفایل من"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // عکس پروفایل
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid'), // یا از شبکه دریافت کن
              ),
            ),
            const SizedBox(height: 16),

            // نام کاربری
            Text(profileController.nameController.text),
            const SizedBox(height: 8),

            // ایمیل
            Text(authController.userEmail.value),
            const SizedBox(height: 10),

            // دکمه‌های اکشن
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed('/edit_profile');
              },
              icon: const Icon(Icons.edit),
              label: const Text("ویرایش پروفایل"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () {
                // کد خروج از حساب
                Get.defaultDialog(
                  title: "خروج",
                  middleText: "آیا مطمئن هستید که می‌خواهید خارج شوید؟",
                  textConfirm: "بله",
                  textCancel: "خیر",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    Get.offAllNamed('/auth'); // بازگشت به صفحه ورود
                  },
                );
              },
              icon: const Icon(Icons.exit_to_app, color: Colors.red),
              label: const Text("خروج از حساب",
                  style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
