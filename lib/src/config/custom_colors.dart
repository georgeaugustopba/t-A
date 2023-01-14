import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(255, 0, 128, .1),
  100: const Color.fromRGBO(255, 0, 128, .2),
  200: const Color.fromRGBO(255, 0, 128, .3),
  300: const Color.fromRGBO(255, 0, 128, .4),
  400: const Color.fromRGBO(255, 0, 128, .5),
  500: const Color.fromRGBO(255, 0, 128, .6),
  600: const Color.fromRGBO(255, 0, 128, .7),
  700: const Color.fromRGBO(255, 0, 128, .8),
  800: const Color.fromRGBO(255, 0, 128, .9),
  900: const Color.fromRGBO(255, 0, 128, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.pink.shade700;

  static MaterialColor customSwatchColor =
      MaterialColor(0xFFE91E63, _swatchOpacity);
}
