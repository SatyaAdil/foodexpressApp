import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:project_Satya/data/repository/user_repo.dart';
import 'package:project_Satya/models/user_model.dart';

import '../models/response_model.dart';
class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  //old one
  //late UserModel _userModel;
  //new one
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;


  Future<ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (kDebugMode) {
      print("test${response.body}");
    }
    if (response.statusCode == 200) {
      _userModel = UserModel.fromjso(response.body);
      _isLoading=true;
      responseModel = ResponseModel(true, "Successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      if (kDebugMode) {
        print(response.statusText);
      }
    }
    update();
    return responseModel;
  }
}
