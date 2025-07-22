import 'package:get/get.dart';
import 'package:project_Satya/base/show_custom_snackbar.dart';
import 'package:project_Satya/routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
