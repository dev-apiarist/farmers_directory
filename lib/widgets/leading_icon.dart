import 'package:flutter/material.dart';

class LeadingIconText extends StatelessWidget {
  Icon icon;
  Color? color;
  final String text;
  double size;
  LeadingIconText(
      {super.key,
      required this.text,
      this.color,
      this.size = 8,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}
