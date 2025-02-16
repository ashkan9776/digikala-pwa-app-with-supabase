import 'package:get/get.dart';
import '../config/supabase_service.dart';

class CategoryController extends GetxController {
  var categories = [].obs;
  var brands = [].obs;
  var selectedCategoryId = ''.obs; // مقدار را String نگه دار
  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    final result = await SupabaseService.getCategories();
    categories.assignAll(result);
  }

void selectCategory(String categoryId) async {
  selectedCategoryId.value = categoryId;  // مقدار باید String بمونه
  final result = await SupabaseService.getBrandsByCategory(categoryId);
  brands.assignAll(result);
}

}
