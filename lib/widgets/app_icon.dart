import 'package:farmers_directory/utils/dimensions.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final IconData icon;

  const AppIcon({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFF756d54),
    this.backgroundColor = Colors.white54,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size! / 2),
          color: backgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.iconSize16,
      ),
    );
  }
}
