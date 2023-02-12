import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Data/repository/popular_product_repo.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularproductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Got product");
      _popularProductList = [];

      _popularProductList.addAll(Product.fromJson(response.body).products);
      //print(_popularProductList);
      _isLoaded =!_isLoaded;

      update();
    } else {
      print("Not entered!");
      
    }
  }

  void setQuentity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuentity(_quantity + 1);
    } else {
      _quantity = checkQuentity(_quantity - 1);
      print("decrement " + _quantity.toString());
    }
    update();
  }

  checkQuentity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: AppColor.mainColor, colorText: Colors.white);

          if(_inCartItems>0){
            _quantity = - _inCartItems;
            return _quantity;
          }
      return 0;
    } else {
      return quantity;
    }
  }

  void initProduct(Productmodel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    print("Exist or not:" + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantty(product);
    }

    print("The quantity in the cart is " + _inCartItems.toString());
  }

  void addItems(Productmodel product) {
    _cart.addItems(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantty(product);
    _cart.items.forEach((key, value) {
      print("Id is " +
          value.id.toString() +
          " and quantity is " +
          value.quantity.toString());
    });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}
