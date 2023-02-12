import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
class ApiChecker{
  static void checkApi(Response response){
    if(response.statusCode ==401){
      Get.offNamed(RouteHelper.getSignin());
  }else{
      showCustomSnackbar(response.statusText!);
    }

    }

}