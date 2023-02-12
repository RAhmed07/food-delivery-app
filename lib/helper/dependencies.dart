import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/location_controller.dart';
import 'package:food_delivery_app/Controllers/order_controller.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/Data/repository/auth_repo.dart';
import 'package:food_delivery_app/Data/repository/cart_repo.dart';
import 'package:food_delivery_app/Data/repository/location_rapo.dart';
import 'package:food_delivery_app/Data/repository/order_repo.dart';
import 'package:food_delivery_app/Data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/Data/repository/recommended_product_repo.dart';
import 'package:food_delivery_app/Data/repository/user_rapo.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/user_controller.dart';


Future <void> init()async {
  //shared preference
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  
  
  //Api client
Get.lazyPut(() => ApiClient(appBaseURl: AppConstant.BASE_URL,sharedPreferences:Get.find()));
Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRapo(apiClient: Get.find(),));

//Repository
Get.lazyPut(() => PopularproductRepo(apiClient: Get.find()));
Get.lazyPut(() => RecommendedproductRepo(apiClient: Get.find()));
Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

//Controller
Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
Get.lazyPut(() => CartController(cartRepo: Get.find()));
Get.lazyPut(() => AuthController(authRepo: Get.find()));
Get.lazyPut(() => UserController(userRepo: Get.find()));
Get.lazyPut(() => LocationController(locationRepo: Get.find()));
Get.lazyPut(() => OrderController(orderRepo: Get.find()));
}