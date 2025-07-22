// lib/widgets/app_icon.dart
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final double size;

  const AppIcon({super.key, 
    required this.icon,
    this.backgroundColor = Colors.grey,
    this.size = 50, required Color iconColor, required double iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}
