import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:get/get.dart';

class RecommendedproductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedproductRepo({required this.apiClient});

  Future <Response> getRecommendedProductList() async{

     return await apiClient.getData(AppConstant.RECOMENDED_PRODUCT_URI);
  }

}