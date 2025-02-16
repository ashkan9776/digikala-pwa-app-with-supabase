import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/model.dart';

class ModelController extends GetxController {
  final supabase = Supabase.instance.client;
  var models = <Model>[].obs;
  var isLoading = true.obs;

  Future<void> fetchModels(String brandId) async {
    try {
      isLoading(true);
      final response = await supabase
          .from('models')
          .select()
          .eq('brand_id', brandId); // فقط مدل‌های مرتبط را بگیر

      models.value = response.map((data) => Model.fromJson(data)).toList();
    } catch (e) {
      print('❌ خطا در دریافت مدل‌ها: $e');
    } finally {
      isLoading(false);
    }
  }
}
