import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final user = Supabase.instance.client.auth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 حساب کاربری",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.9), // شفاف
      ),
      body: Center(
        child: user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('نام کاربری: ${user!.email}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client.auth.signOut();
                      Get.offAll('/main'); // بازگشت به صفحه اصلی بعد از خروج
                    },
                    child: const Text('🚪 خروج از حساب'),
                  ),
                ],
              )
            : const Text("❌ لطفاً وارد حساب کاربری شوید."),
      ),
    );
  }
}
