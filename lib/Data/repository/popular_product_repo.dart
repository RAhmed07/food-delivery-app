import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:get/get.dart';

class PopularproductRepo extends GetxService{
  final ApiClient apiClient;
  PopularproductRepo({required this.apiClient});

  Future <Response> getPopularProductList() async{

     return await apiClient.getData(AppConstant.POPULAR_PRODUCT_URI);
  }

}