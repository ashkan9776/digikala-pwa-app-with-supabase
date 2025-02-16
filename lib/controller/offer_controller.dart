import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OfferController extends GetxController {
  final supabase = Supabase.instance.client;
  var offers = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOffers(); // ✅ اجرای خودکار هنگام مقداردهی کنترلر
  }

  Future<void> fetchOffers() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('offers')
          .select('*')
          .order('created_at', ascending: false)
          .limit(5);
      offers.value = response;
    } catch (e) {
      print("❌ خطا در دریافت محصولات شگفت‌انگیز: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
