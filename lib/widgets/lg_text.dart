import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class LargeText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overflow;

  LargeText(
      {super.key,
      required this.text,
      this.color = const Color(0xFF1E1E1E),
      this.size = 0,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: size == 0 ? Dimensions.font20 : size),
    );
  }
}
