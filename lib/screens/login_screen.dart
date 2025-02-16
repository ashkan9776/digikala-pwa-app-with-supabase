import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ورود")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "ایمیل")),
            TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "رمز عبور"),
                obscureText: true),
            const SizedBox(height: 20),
            Obx(() => authController.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      authController.signIn(
                          emailController.text, passwordController.text);
                    },
                    child: const Text("ورود"),
                  )),
            TextButton(
              onPressed: () => Get.toNamed('/register'),
              child: const Text("حساب ندارید؟ ثبت‌نام"),
            )
          ],
        ),
      ),
    );
  }
}
