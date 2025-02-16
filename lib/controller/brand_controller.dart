import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/brands.dart';

class BrandController extends GetxController {
  final supabase = Supabase.instance.client;
  var brands = <Brand>[].obs;
  var isLoading = true.obs;

  Future<void> fetchBrands(String categoryId) async {
    try {
      isLoading(true);
      final response = await supabase
          .from('brands')
          .select()
          .eq('category_id', categoryId); // فقط برندهای مرتبط را بگیر

      brands.value = response.map((data) => Brand.fromJson(data)).toList();
    } catch (e) {
      print('❌ خطا در دریافت برندها: $e');
    } finally {
      isLoading(false);
    }
  }
}
