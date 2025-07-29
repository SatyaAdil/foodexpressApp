import 'package:get/get.dart' show BoolExtension, GetxController, Rx, RxBool;
import 'package:project_Satya/models/signup_body_model.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  final RxBool _isLoggedIn = false.obs;
  final Rx<UserModel?> _user = Rx<UserModel?>(null);

  bool get isLoggedIn => _isLoggedIn.value;
  UserModel? get user => _user.value;

  bool? get isLoading => null;

  Future<void> getUserInfo() async {
    // Simulasi fetch data
    await Future.delayed(const Duration(seconds: 1));
    _user.value = UserModel(
      name: "John Doe",
      phone: "+628123456789",
      email: "johndoe@mail.com",
    );
  }

  Future<void> logout() async {
    _isLoggedIn.value = false;
    _user.value = null;
  }

  void login(String phone, [String? password]) {
    _isLoggedIn.value = true;
    getUserInfo();
  }

  registration(SignUpBody signUpBody) {}

  bool userLoggedIn() {
    return _isLoggedIn.value;
  }

  void clearSharedData() {}
}
