import 'package:flutter/material.dart';

class LeadingIconText extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String text;
  final double textSize;
  final double iconSize;
  const LeadingIconText(
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
