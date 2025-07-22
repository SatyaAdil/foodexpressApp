// lib/widgets/account_widget.dart
import 'package:flutter/material.dart';
import 'package:project_Satya/widgets/app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const AccountWidget({super.key, required this.icon, required this.text, required BigText bigText, required AppIcon appIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(width: 10),
        BigText(text: text),
      ],
    );
  }
}
