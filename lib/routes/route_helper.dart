// lib/routes/route_helper.dart
class RouteHelper {
  static const String signIn = '/sign-in';
  static const String splashPage = '/splash';

  // ignore: prefer_typing_uninitialized_variables
  static var routes;

  static String initial = signIn;

  static String getSignInPage() => signIn;
  static String getSplashPage() => splashPage;

  static String getInitial() {
    return initial;
  }

  static String getCartPage() {
    return '/cart';
  }

  static String getAddressPage() {
    return '/address';
  }

  static String getOrderSuccessPage(String string, String s) {
    return '/order-success';
  }
}


// update