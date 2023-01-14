import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/models/cart/cart_item_model.dart';
import 'package:lojateamodas/src/models/order/order_model.dart';
import 'package:lojateamodas/src/pages/orders/controller/order_controller.dart';
import 'package:lojateamodas/src/pages/orders/view/components/order_status_widget.dart';
import 'package:lojateamodas/src/pages/widgets/payment_dialog.dart';
import 'package:lojateamodas/src/services/utils/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: GetBuilder<OrderController>(
            init: OrderController(order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      utilsServices.formatDateTime(order.createDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              //lista de produtos
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children:
                                        controller.order.items.map((orderItem) {
                                      return _orderItemWidget(
                                        utilsServices: utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              //status pedido
                              VerticalDivider(
                                color: Colors.pink.shade300,
                                width: 8,
                              ),
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  isOverdue: order.overdueDateTime.isBefore(
                                    DateTime.now(),
                                  ),
                                  status: order.status!,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //total
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Total: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    utilsServices.priceToCurrency(order.total),
                              ),
                            ],
                          ),
                        ),

                        //botao de pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => PaymentDialog(order: order),
                              );
                            },
                            icon: const Icon(
                              Icons.api_sharp,
                            ),
                            label: const Text(
                              'Ver QR Code Pix',
                            ),
                          ),

                          // caso queira apresentar outro ícone passo no replacement: ,
                        ),
                      ],
              );
            },
          )),
    );
  }
}

// ignore: camel_case_types
class _orderItemWidget extends StatelessWidget {
  const _orderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.orderItem,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              orderItem.item.itemName,
            ),
          ),
          Text(
            utilsServices.priceToCurrency(
              orderItem.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
