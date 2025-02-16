import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var products = <Map<String, dynamic>>[].obs;
  var selectedProduct = Rxn<Map<String, dynamic>>(); // ✅ محصول انتخاب‌شده
  var isLoading = false.obs;

  Future<void> fetchProductsByBrand(String brandId) async {
    try {
      isLoading.value = true;
      final List<Map<String, dynamic>> response =
          await supabase.from('models').select('*').eq('brand_id', brandId);

      products.value = response;
    } catch (e) {
      print("❌ خطا در دریافت محصولات: $e");
      Get.snackbar("خطا", "مشکلی در دریافت محصولات به وجود آمد.");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetails(String productId) async {
    try {
      isLoading.value = true;

      final response = await supabase
          .from('models')
          .select('*')
          .eq('id', productId)
          .maybeSingle(); // ✅ دریافت یک مقدار

      selectedProduct.value = response;
    } catch (e) {
      print("❌ خطا در دریافت جزئیات محصول: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
