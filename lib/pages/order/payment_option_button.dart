import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:project_Satya/controllers/order_controller.dart';
import 'package:project_Satya/utils/dimensions.dart';

import '../../utils/colors.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final int index;
  const PaymentOptionButton({Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder:(orderController){
      bool selected = orderController.paymentIndex==index;
      return InkWell(
        onTap: ()=>orderController.setPaymentIndex(index),
        child: Container(
          padding: EdgeInsets.only(bottom: Dimensions.height10/2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20/4),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1,
                )
              ]
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: selected?AppColors.mainColor:Theme.of(context).disabledColor,
            ),
            title: Text(title),
            subtitle: Text(
              subTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: selected?Icon(Icons.check_circle, color: Theme.of(context).primaryColor,):null,
          ),
        ),
      );
    });
  }
}
