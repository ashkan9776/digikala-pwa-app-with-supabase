import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    orderController.fetchOrders(); // دریافت لیست سفارشات

    return Scaffold(
      appBar: AppBar(title: const Text("🛍 سفارشات من")),
      body: Obx(() {
        if (orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.orders.isEmpty) {
          return const Center(child: Text("سفارشی یافت نشد"));
        }

        return ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            final order = orderController.orders[index];

            // تعیین رنگ و دکمه وضعیت بر اساس وضعیت سفارش
            String status = order['status'] ?? 'پرداخت نشده';
            Color statusColor;
            String actionText;

            switch (status) {
              case 'پرداخت نشده':
                statusColor = Colors.red;
                actionText = 'پرداخت نشده';
                break;
              case 'در حال پردازش':
                statusColor = Colors.orange;
                actionText = 'در حال پردازش';
                break;
              case 'پرداخت شده':
                statusColor = Colors.green;
                actionText = 'پرداخت شده';
                break;
              default:
                statusColor = Colors.grey;
                actionText = 'خطا';
            }

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: order['product_image_url'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          order['product_image_url'],
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                    : const Icon(Icons.image_not_supported),
                title: Text(
                  "مبلغ: ${order['total_price']} تومان",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order['product_name'] ?? 'نام محصول نامشخص',
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Text("تاریخ: ${order['created_at']}"),
                    const SizedBox(height: 5),
                    Text(
                      "وضعیت: $status",
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: statusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () {
                    // به روز رسانی وضعیت سفارش
                    String nextStatus;
                    if (status == 'پرداخت نشده') {
                      nextStatus = 'در حال پردازش';
                    } else if (status == 'در حال پردازش') {
                      nextStatus = 'پرداخت شده';
                    } else {
                      nextStatus = 'پرداخت شده';
                    }

                    orderController.updateOrderStatus(order['id'], nextStatus);
                  },
                  child: Text(
                    actionText,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
