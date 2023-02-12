
import 'package:food_delivery_app/Data/repository/user_rapo.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';
class UserController extends GetxController implements GetxService {
  final UserRapo userRepo;

  UserController({required this.userRepo});

  bool _isLoadding = false;
   UserModel? _userModel;

  bool get isLoadding => _isLoadding;

  UserModel? get userModel => _userModel;

  Future <ResponseModel> getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoadding = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModel;
  }
}