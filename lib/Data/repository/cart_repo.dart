import 'dart:convert';

import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory =[];
  void addToCartList(List<CartModel> cartList) {
    //sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
    //sharedPreferences.remove(AppConstant.CART_LIST);
    var time = DateTime.now().toString();
    cart = [];
    //convert objects to string because sharedPreference can get the string only
    cartList.forEach((element) {
      
      element.time = time;
      return cart.add(jsonEncode(element));
    } );
    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstant.CART_LIST));
    //getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstant.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
      print("inside getCartList"+carts.toString());
    }

    List<CartModel> cartList = [];
    carts.forEach((element) { 
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }
  List <CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
      //cartHistory =[];
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory =[];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))),);


    return cartListHistory;
  }

  void addtoCartHistory(){
  if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
    cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
  }

    for(int i=0; i<cart.length;i++){

     cartHistory.add(cart[i]);
    }
    cart =[];
    sharedPreferences.setStringList(AppConstant.CART_HISTORY_LIST, cartHistory);


  }
  void removeCart(){
    cart =[];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }

  void clearCartHistory(){
    removeCart();
    cartHistory =[];
    sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);

  }

  void removeCartSharedPreference(){
    sharedPreferences.remove(AppConstant.CART_LIST);
    sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
  }
}
