import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:project_Satya/base/custom_loader.dart";
import 'package:project_Satya/pages/auth/sign_up_page.dart';
import 'package:project_Satya/utils/colors.dart';
import 'package:project_Satya/utils/dimensions.dart';
import 'package:project_Satya/widgets/app_text_field.dart';
import 'package:project_Satya/widgets/big_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void login(AuthController authController){

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "phone number");

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "password");

      }else if(password.length<6){
        showCustomSnackBar("Password cannot be less than six characters", title: "Password");

      }else{
        authController.login(phone, password);
          // login is now handled inside the AuthController
          // and will navigate to the appropriate screen
          // error handling is now done in AuthController
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,

        body: GetBuilder<AuthController>(builder: (authController){
          return (authController.isLoading ?? false) == false ? SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //app logo
                SizedBox(
                  height: Dimensions.screenHeight*0.25,
                  child: const Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 80,
                      backgroundImage: AssetImage(
                          "assets/image/Bella verona 1.png"
                      ),
                    ),
                  ),
                ),
                //welcome
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            fontSize: Dimensions.font20*3+Dimensions.font20/2,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Sign in to your account",
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            //fontWeight: FontWeight.bold
                            color: Colors.grey[500]
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height20,),

                //Your phone
                AppTextField(textController: phoneController,
                    hintText: "Phone",
                    icon: Icons.phone),
                SizedBox(height: Dimensions.height20,),
                //Your password
                AppTextField(textController: passwordController,
                    hintText: "Password",
                    icon: Icons.password_sharp, isObscure:true),

                SizedBox(height: Dimensions.height20,),
                //tag line
                Row(children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign in to your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )),
                  SizedBox(width: Dimensions.width20,)
                ],),

                SizedBox(height: Dimensions.screenHeight*0.05,),
                //Sign in
                GestureDetector(
                  onTap:(){
                    login(authController);
                  },
                  child: Container(
                    width: Dimensions.screenWidth/2,
                    height: Dimensions.screenHeight/13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor,
                    ),
                    child: Center(
                      child: BigText(
                        text: "Sign In",
                        size: Dimensions.font20+Dimensions.font20/2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.screenHeight*0.05,),
                //sign up options
                RichText(text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>const SignUpPage(), transition: Transition.fade),
                          text: " Create",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20
                          ))
                    ]
                )),


              ],
            ),
          ):const CustomLoader();
        })
    );
  }
}
