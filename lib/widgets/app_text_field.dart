import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  bool maxLines;
  AppTextField({Key? key,

  required this.textController,
  required this.hintText,
  required this.icon,
    this.isObscure=false,
  this.maxLines=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimensions.radius15),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: const Offset(1, 1),
                  color: Colors.grey.withAlpha(51) // 0.2 * 255 ≈ 51
              )
            ]
        ),
        child: TextField(
          maxLines: maxLines?3:1,
          obscureText: isObscure?true:false,
          controller: textController,
          decoration: InputDecoration(
            //hint text
            hintText: hintText,
            //prefixIcon
            prefixIcon: Icon(icon, color: AppColors.yellowColor,),
            // focusedBorder
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                borderSide: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            // enabledBoarder
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: const BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            // border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),

            ),

          ),
        )
    );
  }
}
