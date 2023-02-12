import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:get/get.dart';

class UserRapo{
  final ApiClient apiClient;
  UserRapo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.USER_INFO);
  }
}