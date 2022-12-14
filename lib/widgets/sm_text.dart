import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final TextAlign? align;

  const SmallText({
    super.key,
    required this.text,
    this.align,
    this.height = 1.2,
    this.color = const Color(0xFF1E1E1E),
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.sm : size,
          height: height),
    );
  }
}
