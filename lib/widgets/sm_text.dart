import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  SmallText({
    super.key,
    required this.text,
    this.height = 1.2,
    this.color = const Color(0xFF1E1E1E),
    this.size = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font14 : size,
          height: height),
    );
  }
}
