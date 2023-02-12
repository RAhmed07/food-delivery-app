import 'package:food_delivery_app/Data/repository/order_repo.dart';
import 'package:food_delivery_app/models/place_order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController implements GetxService{
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callBack)async {
    _isLoading = true;
        Response response = await orderRepo.placeOrder(placeOrder);
        if(response.statusCode == 200){
          _isLoading =false;
          String message = response.body['message'];
          String orderID = response.body['order_id'];
          callBack(true, message,orderID);
        }else{
          callBack(false,response.statusText!,'-1');
        }
  }
}