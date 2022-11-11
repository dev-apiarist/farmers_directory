import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

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
      this.textSize = 0,
      this.iconSize = 0,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: iconSize == 0 ? Dimensions.font14 - 1 : iconSize,
          color: color,
        ),
        SizedBox(
          width: Dimensions.width5,
        ),
        Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: textSize == 0 ? Dimensions.font14 + 1 : textSize),
        ),
      ],
    );
  }
}
