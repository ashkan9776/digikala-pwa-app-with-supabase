import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient supabase = Supabase.instance.client;

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await supabase.from('categories').select();
    return response;
  }

  static Future<List<Map<String, dynamic>>> getBrandsByCategory(
      String categoryId) async {
    final response = await supabase
        .from('brands')
        .select()
        .eq('category_id', categoryId); // مقدار `categoryId` را String نگه دار
    return response;
  }
}
