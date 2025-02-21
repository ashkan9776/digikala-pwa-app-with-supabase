import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/auth_controller.dart';
import '../controller/cart_controller.dart';
import '../controller/banner_controller.dart';
import '../controller/offer_controller.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final CartController cartController = Get.put(CartController());
  final BannerController bannerController = Get.put(BannerController());
  final OfferController offerController = Get.put(OfferController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 🔹 حذف دکمه برگشت
        title: const Text("🏠 دیجی شاپ",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.9), // شفاف
        actions: [
          Obx(() {
            return authController.userEmail.isNotEmpty
                ? PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        authController.signOut();
                      } else if (value == 'orders') {
                        Get.offAll('/orders');
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'orders',
                        child: const Text("🛍 سفارشات من"),
                        onTap: () {
                          Get.toNamed('/orders');
                        },
                      ),
                      const PopupMenuItem(
                          value: 'logout', child: Text("🚪 خروج")),
                    ],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 5),
                          Text(authController.userEmail.value.substring(
                              0, authController.userEmail.value.indexOf('@'))),
                        ],
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () => Get.offAll('/auth'),
                    child: const Text("ورود / ثبت‌نام"),
                  );
          }),
          Obx(() => Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => Get.toNamed('/cart'),
                  ),
                  if (cartController.cartItems.isNotEmpty)
                    Positioned(
                      right: 3,
                      top: 1,
                      child: CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: Text(
                          cartController.cartItems.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ✅ اسلایدر بنرها

            Obx(() {
              if (bannerController.isLoading.value) {
                return SizedBox(
                  height: 200.0,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal, // چینش افقی

                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }),
                      )),
                );
              }

              if (bannerController.banners.isEmpty) {
                return const Center(child: Text("بنری یافت نشد."));
              }

              return CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  autoPlay: true, // پخش خودکار
                  autoPlayInterval: const Duration(seconds: 3),
                  enlargeCenterPage: true, // بزرگ‌تر شدن بنر وسط
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.9,
                ),
                items: bannerController.banners.map((url) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        width: double.infinity,
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            Divider(
              color: Colors.grey.shade400,
              endIndent: 30,
              indent: 30,
              thickness: 0.5,
            ),

            // ✅ محصولات شگفت‌انگیز به صورت ردیفی
            Obx(
              () {
                if (offerController.isLoading.value) {
                  return SizedBox(
                    height: 200.0,
                    child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal, // چینش افقی

                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                );
                              }),
                        )),
                  );
                }

                if (offerController.offers.isEmpty) {
                  return const Center(
                      child: Text("محصولات شگفت‌انگیز یافت نشد."));
                }

                return SizedBox(
                  height: 220, // ارتفاع کارت‌ها
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // چینش افقی
                    itemCount: offerController.offers.length,
                    itemBuilder: (context, index) {
                      final offer = offerController.offers[index];

                      return Container(
                        color: Colors.red.shade300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20),
                              child: Column(
                                children: [
                                  // تصویر محصول
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      offer['image'] ??
                                          'https://via.placeholder.com/150',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.broken_image,
                                                  size: 100),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  // نام محصول
                                  Text(
                                    offer['title'] ?? 'بدون نام محصول',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 20),
                                  // قیمت اصلی و قیمت تخفیف خورده
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "قیمت اصلی: ${offer['original_price'] ?? 'N/A'} تومان",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "قیمت ویژه: ${offer['discounted_price'] ?? 'N/A'}",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 3),
                                      CircleAvatar(
                                        radius: 13,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          " ${offer['discount'] ?? 'N/A'} %",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ✅ سایر بخش‌های خانه

            Obx(() {
              if (bannerController.isLoading.value) {
                return SizedBox(
                  height: 200.0,
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal, // چینش افقی

                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            }),
                      )),
                );
              }

              if (bannerController.banners.isEmpty) {
                return const Center(child: Text("بنری یافت نشد."));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: bannerController.banners.take(4).map((url) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/categories'),
                      child: const Text('📂 مشاهده دسته‌بندی‌ها'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => Get.toNamed('/orders'),
                      child: const Text('🛍 مشاهده سفارشات'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
