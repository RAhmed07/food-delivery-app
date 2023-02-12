import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/Data/repository/auth_repo.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_constant.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoadding=false;
  bool get isLoadding => _isLoadding;

  Future <ResponseModel>registration(SignUpBody signUpBody) async{
    _isLoadding =true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if(response.statusCode == 200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);


    }else{
      responseModel = ResponseModel(false, response.statusText!);

    }
    _isLoadding =false;
    update();
    return responseModel;
  }

  Future <ResponseModel>login(String phone,String password ) async{

    _isLoadding =true;
    update();
    Response response = await authRepo.login(phone,password);
    late ResponseModel responseModel;
    if(response.statusCode == 200){

      authRepo.saveUserToken(response.body["token"]);
      print("My token is "+response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);


    }else{
      responseModel = ResponseModel(false, response.statusText!);

    }
    _isLoadding =false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password)  {
   authRepo.saveUserNumberAndPassword(number, password);

  }

  bool userLoggedIn()  {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }
}