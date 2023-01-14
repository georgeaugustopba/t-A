import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/pages/orders/controller/all_orders_controller.dart';
import 'package:lojateamodas/src/pages/orders/view/components/order_tile.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
        centerTitle: true,
        leading: GetBuilder<AllOrdersController>(
          builder: (controller) {
            return MediaQuery.of(context).size.width < 800
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        controller.getAllOrders();
                      });
                    },
                    icon: const Icon(
                      Icons.rotate_right,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        Get.back();
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  );
          },
        ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: GetBuilder<AllOrdersController>(
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () => controller.getAllOrders(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, index) => const SizedBox(height: 10),
                  itemCount: controller.allOrders.length,
                  itemBuilder: (_, index) => OrderTile(
                    order: controller.allOrders[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
