import 'package:flutter/material.dart';

class LeadingIconText extends StatelessWidget {
  IconData icon;
  Color? color;
  final String text;
  double textSize;
  double iconSize;
  LeadingIconText(
      {super.key,
      required this.text,
      this.color,
      this.textSize = 15,
      this.iconSize = 13,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: color,
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          text,
          style: TextStyle(color: color, fontSize: textSize),
        ),
      ],
    );
  }
}
