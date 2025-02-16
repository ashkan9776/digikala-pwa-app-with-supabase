import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BannerController extends GetxController {
  final supabase = Supabase.instance.client;
  var banners = <String>[].obs; // لیست بنرها
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('banners').select('image_url');

      banners.value = response.map((e) => e['image_url'].toString()).toList();
    } catch (e) {
      print("❌ خطا در دریافت بنرها: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
