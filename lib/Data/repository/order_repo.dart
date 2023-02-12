import 'package:food_delivery_app/Data/api/api_client.dart';
import 'package:food_delivery_app/models/place_order_model.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:get/get.dart';

class OrderRepo{
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstant.PLACE_ORDER_URI,placeOrder.toJson());
  }
}