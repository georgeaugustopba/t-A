import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojateamodas/src/components/card/card_text_field.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';

class CardBack extends StatelessWidget {
  final FocusNode cvvFocus;

  const CardBack({Key? key, required this.cvvFocus}) : super(key: key);

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
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 16),
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    //    height: 60,
                    color: Colors.grey[500],
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    child: CardTextField(
                      onSubmitted: (_) {},
                      focusNode: cvvFocus,
                      hint: '123',
                      maxLenght: 3,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      validator: (cvv) {
                        if (cvv!.length != 3) {
                          return 'Inválido';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
