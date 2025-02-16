import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  var isLoading = false.obs;
  var userEmail = ''.obs; // ذخیره ایمیل کاربر لاگین شده

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      userEmail.value = user.email ?? "کاربر مهمان";
    } else {
      userEmail.value = '';
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      await supabase.auth.signUp(email: email, password: password);
      isLoading.value = false;
      getUser();
      Get.snackbar("✅ موفق!", "حساب شما با موفقیت ایجاد شد.");
      Get.offAll('/main');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("❌ خطا!", e.toString());
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await supabase.auth.signInWithPassword(email: email, password: password);
      isLoading.value = false;
      getUser();
      Get.offAll('/main');
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("❌ خطا!", e.toString());
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    userEmail.value = ''; // حذف اطلاعات کاربر بعد از خروج
    Get.offAll('/login');
  }
}
