// lib/widgets/big_text.dart
import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const BigText({super.key, 
    required this.text,
    this.size = 18,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
