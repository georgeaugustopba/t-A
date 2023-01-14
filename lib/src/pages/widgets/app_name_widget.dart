import 'package:flutter/material.dart';
import 'package:lojateamodas/src/config/custom_colors.dart';

class AppNamedWidget extends StatelessWidget {
  final Color? teaTitleColor;
  final Color? modasTitleColor;
  final double textSize;
  const AppNamedWidget({
    Key? key,
    this.teaTitleColor,
    this.textSize = 45,
    this.modasTitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width > 700 ? textSize : 27,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'T&A ',
            style: TextStyle(
              color: teaTitleColor ?? Colors.black,
            ),
          ),
          TextSpan(
            text: 'Moda Feminina',
            style: TextStyle(
              color: modasTitleColor ?? CustomColors.customContrastColor,
            ),
          ),
        ],
      ),
    );
  }
}
