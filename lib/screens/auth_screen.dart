import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthScreen({super.key});

  void signUp() async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.snackbar("موفقیت", "ثبت‌نام انجام شد! لطفاً ایمیل خود را تأیید کنید.");
    } catch (e) {
      Get.snackbar("خطا", e.toString());
    }
  }

  void signIn() async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAllNamed('/main');
    } catch (e) {
      Get.snackbar("خطا", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود / ثبت‌نام')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'ایمیل'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'رمز عبور'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUp,
              child: const Text('ثبت‌نام'),
            ),
            ElevatedButton(
              onPressed: signIn,
              child: const Text('ورود'),
            ),
          ],
        ),
      ),
    );
  }
}
