import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:lojateamodas/src/pages/base/firebase/custom_firebase.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    //final service = Provider.of<ChatNotificationService>(context);

    final service = Get.find<CustomFirebaseController>();
    final items = service.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Notificações'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CustomFirebaseController>(
                builder: (service) {
                  if (service.items.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_off_rounded,
                          size: 40,
                          color: CustomColors.customSwatchColor,
                        ),
                        const Text('Não há notificações'),
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: service.itemsCount,
                    itemBuilder: (ctx, i) => ListTile(
                      title: Text(items[i].title),
                      subtitle: Text(items[i].body),
                      onTap: () => service.remove(i),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
