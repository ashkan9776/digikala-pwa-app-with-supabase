import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ویرایش پروفایل"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // عکس پروفایل
            Center(
              child: Stack(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 50,
                      backgroundImage: profileController
                              .imageUrl.value.isNotEmpty
                          ? NetworkImage(profileController.imageUrl.value)
                          : const AssetImage("assets/profile_placeholder.png")
                              as ImageProvider,
                    ),
                  ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       profileController.pickImage();
                  //     },
                  //     child: CircleAvatar(
                  //       radius: 18,
                  //       backgroundColor: Colors.blue,
                  //       child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // فیلد نام کاربری
            TextField(
              controller: profileController.nameController,
              decoration: const InputDecoration(
                labelText: "نام کاربری",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // فیلد ایمیل (فقط نمایش، غیر قابل تغییر)
            TextField(
              controller: profileController.emailController,
              decoration: const InputDecoration(
                labelText: "ایمیل",
                border: OutlineInputBorder(),
              ),
              enabled: false, // ایمیل قابل تغییر نیست
            ),
            const SizedBox(height: 20),

            // دکمه ذخیره تغییرات
            ElevatedButton(
              onPressed: () {
                profileController.updateProfile();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text("ذخیره تغییرات"),
            ),
          ],
        ),
      ),
    );
  }
}
