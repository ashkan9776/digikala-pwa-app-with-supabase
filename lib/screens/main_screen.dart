import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/home_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';
import 'catgories_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    CategoriesScreen(),
    OrdersScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: pages[selectedIndex.value],
          bottomNavigationBar: NavigationBar(
            selectedIndex: selectedIndex.value,
            onDestinationSelected: (index) => selectedIndex.value = index,
            height: 65,
            indicatorColor: Colors.blue.shade100,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'خانه'),
              NavigationDestination(
                  icon: Icon(Icons.category_outlined),
                  selectedIcon: Icon(Icons.category),
                  label: 'دسته‌بندی'),
              NavigationDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list),
                  label: 'سفارشات'),
              NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'پروفایل'),
            ],
          ),
        ));
  }
}
