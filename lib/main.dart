import 'package:digikala_pwa/screens/login_screen.dart';
import 'package:digikala_pwa/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'controller/cart_controller.dart';
import 'controller/order_controller.dart';
import 'screens/auth_screen.dart';
import 'screens/brand_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/catgories_screen.dart';
import 'screens/home_screen.dart';
import 'screens/main_screen.dart';
import 'screens/model_details_screen.dart';
import 'screens/model_screen.dart';
import 'screens/product_details_screen.dart';
import 'screens/orders_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.initialize();

  final session = Supabase.instance.client.auth.currentSession;

  runApp(MyApp(isLoggedIn: session != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // مقداردهی اولیه کنترلرهای GetX
    Get.put(CartController());
    Get.put(OrderController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/main' : '/auth',
      getPages: [
        GetPage(
            name: '/main',
            page: () => MainScreen()), // 🔹 صفحه اصلی با Bottom Navigation
        GetPage(name: '/auth', page: () => AuthScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/brands', page: () => BrandScreen()),

        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/models', page: () => ModelScreen()),
        GetPage(
            name: '/model-details',
            page: () => const ModelDetailsScreen()), // مسیر جدید
        GetPage(name: '/categories', page: () => CategoriesScreen()),
        GetPage(name: '/cart', page: () => CartScreen()), // مسیر سبد خرید
        GetPage(
            name: '/product-details', page: () => const ProductDetailsScreen()),
        GetPage(name: '/orders', page: () => OrdersScreen()),
      ],
    );
  }
}
