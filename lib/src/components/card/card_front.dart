import 'package:brasil_fields/brasil_fields.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojateamodas/src/components/card/card_text_field.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:math' as math;

class CardFront extends StatelessWidget {
  final MaskTextInputFormatter dateFormater =
      MaskTextInputFormatter(mask: '##/####', filter: {'#': RegExp('[0-9]')});

  final FocusNode numberFocus;
  final FocusNode dateFocus;
  final FocusNode nameFocus;
  final VoidCallback finishedFront;

  CardFront(
      {Key? key,
      required this.numberFocus,
      required this.dateFocus,
      required this.nameFocus,
      required this.finishedFront})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16,
        ),
      ),
      elevation: 16,
      child: Container(
        height: 200,
        color: CustomColors.customSwatchColor.shade800,
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 20,
          right: 20,
          top: 0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CardTextField(
                    maxLenght: 22,
                    title: 'Número',
                    hint: '0000 0000 0000 0000',
                    textInputType: TextInputType.number,
                    bold: true,
                    inputFormaters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CartaoBancarioInputFormatter(),
                    ],
                    onSubmitted: (_) {
                      dateFocus.requestFocus();
                    },
                    focusNode: numberFocus,
                    validator: (number) {
                      if (number!.length != 19) {
                        return 'Inválido';
                      } else if (detectCCType(number) ==
                          CreditCardType.unknown) {
                        return 'Inválido';
                      }
                      return null;
                    },
                  ),
                  CardTextField(
                    maxLenght: 8,
                    focusNode: dateFocus,
                    inputFormaters: [dateFormater],
                    title: 'Validade',
                    hint: '09/2023',
                    textInputType: TextInputType.number,
                    validator: (date) {
                      if (date!.isEmpty || date.length != 7) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      nameFocus.requestFocus();
                    },
                  ),
                  CardTextField(
                    maxLenght: 30,
                    focusNode: nameFocus,
                    inputFormaters: const [],
                    title: 'Titular',
                    hint: 'Maria Aparecida da Silva',
                    textInputType: TextInputType.text,
                    bold: true,
                    validator: (name) {
                      if (name!.isEmpty) return 'Inválido';
                      return null;
                    },
                    onSubmitted: (_) {
                      finishedFront();
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 25,
                    left: 32,
                    right: 10,
                    top: 25,
                  ),
                  child: Image.asset(
                    "images/chipcartao.png",
                    fit: BoxFit.fitWidth,
                    height: 30,
                    width: 40,
                    scale: 2,
                  ),
                ),
                Transform.rotate(
                  angle: 160 * math.pi / 320,
                  child: const Icon(
                    Icons.wifi_sharp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
