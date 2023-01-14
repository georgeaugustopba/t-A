import 'package:flutter/material.dart';

class CustomIconButtom extends StatelessWidget {
  const CustomIconButtom({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.color,
    required this.size,
  }) : super(key: key);
  final VoidCallback onTap;
  final IconData iconData;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              iconData,
              // ignore: unnecessary_null_comparison
              color: onTap != null ? color : Colors.grey[400],
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}
