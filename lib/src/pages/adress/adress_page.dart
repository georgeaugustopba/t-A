import 'package:flutter/material.dart';
import 'package:lojateamodas/src/components/adress/adress_card.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor.shade300,
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(children: const [
        AddressCard(),
      ]),
    );
  }
}
