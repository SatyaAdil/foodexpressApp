import 'package:flutter/material.dart';
import 'package:project_satya/utils/colors.dart';
import 'package:project_satya/widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExist;
  final Function? onBackPressed;
  const CustomAppBar({Key? key,
    required this.title,
    this.backButtonExist=true,
    this.onBackPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BigText(text: title, color: Colors.white,),
      centerTitle: true,
      backgroundColor: AppColors.mainColor,
      elevation: 0,
      leading: backButtonExist?IconButton(
          onPressed: ()=>onBackPressed!=null?onBackPressed!()
              :Navigator.pushReplacementNamed(context, "/initial"),
          icon: const Icon(Icons.arrow_back_ios)):const SizedBox(),
    );
  }

  @override
  Size get preferredSize => const Size(500, 55);
}


// update