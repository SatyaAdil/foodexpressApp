import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_Satya/base/custom_loader.dart';
import 'package:project_Satya/controllers/auth_controller.dart';
import 'package:project_Satya/controllers/cart_controller.dart';
import 'package:project_Satya/controllers/location_controller.dart';
import 'package:project_Satya/controllers/user_controller.dart';
import 'package:project_Satya/routes/route_helper.dart';
import 'package:project_Satya/widgets/app_icon.dart';
import 'package:project_Satya/widgets/big_text.dart';
import '../../base/custom_app_bar.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: const CustomAppBar(title: "Profile"),
      body: GetBuilder<UserController>(builder: (userController) {
        return userLoggedIn 
          ? (userController.isLoading 
              ? Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  child: Column(
                    children: [
                      AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                        iconSize: Dimensions.height45 + Dimensions.height30,
                        size: Dimensions.height15 * 10,
                      ),
                      SizedBox(height: Dimensions.height30),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Name
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.person,
                                  backgroundColor: AppColors.mainColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: userController.userModel?.name ?? "N/A"),
                              ),
                              SizedBox(height: Dimensions.height20),
                              // Phone
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.phone,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: userController.userModel?.phone ?? "N/A"),
                              ),
                              SizedBox(height: Dimensions.height20),
                              // Email
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.email,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: userController.userModel?.email ?? "N/A"),
                              ),
                              SizedBox(height: Dimensions.height20),
                              // Address
                              GetBuilder<LocationController>(builder: (locationController) {
                                return GestureDetector(
                                  onTap: () => Get.offNamed(RouteHelper.getAddressPage()),
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: userLoggedIn && locationController.addressList.isEmpty
                                        ? "Fill in your address"
                                        : "Your address"
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(height: Dimensions.height20),
                              // Messages
                              AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.message_outlined,
                                  backgroundColor: Colors.redAccent,
                                  iconColor: Colors.white,
                                  iconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(text: "Messages"),
                              ),
                              SizedBox(height: Dimensions.height20),
                              // Logout
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>().userLoggedIn()) {
                                    Get.find<AuthController>().clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>().clearCartHistory();
                                    Get.find<LocationController>().clearAddressList();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Logout"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const CustomLoader())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 8,
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/signintocontinue.png"),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getSignInPage()),
                    child: Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
                      margin: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(
                        child: BigText(
                          text: "Sign in",
                          color: Colors.white,
                          size: Dimensions.font26,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
      }),
    );
  }
}