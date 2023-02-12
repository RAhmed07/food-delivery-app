import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/location_controller.dart';
import 'package:food_delivery_app/Controllers/order_controller.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/Controllers/user_controller.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/models/place_order_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../Controllers/cart_controller.dart';
import '../../Controllers/cart_controller.dart';
import '../../Controllers/cart_controller.dart';
import '../../Controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.width10 * 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: AppIcon(
                        icon: Icons.arrow_back,
                        iconColor: Colors.white,
                        backgroundColor: AppColor.mainColor,
                        iconSize: Dimensions.iconSize24,
                      )),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home,
                        iconColor: Colors.white,
                        backgroundColor: AppColor.mainColor,
                        iconSize: Dimensions.iconSize24,
                      )),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColor.mainColor,
                    iconSize: Dimensions.iconSize24,
                  )
                ],
              )),
      GetBuilder<CartController>(builder: (cartController){
        return cartController.getItems.length >0 ?    Positioned(
              top: Dimensions.height20 * 6,
              right: Dimensions.width20,
              left: Dimensions.width20,
              bottom: 0,
              child: Container(
                //color: Colors.red,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (_, index) {
                              return Container(
                                height: Dimensions.height20 * 5,
                                width: double.maxFinite,
                                //color: Colors.blue,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex =
                                            Get.find<PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                                  
                                        
                                        if (popularIndex >= 0) {
                                             Get.toNamed(RouteHelper.getPopularFood(
                                            popularIndex, "cartpage"));
                                         
                                        } else {
                                          var recommendedIndex = Get.find<
                                                  RecommendedProductController>()
                                              .recommendedProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                          if(recommendedIndex<0){
                                             Get.snackbar("History product", "Product review is not avaiable for history products!",backgroundColor: AppColor.mainColor,colorText: Colors.white);

                                          }else{
                                            Get.toNamed(
                                              RouteHelper.getrecommendedFood(
                                                  recommendedIndex,
                                                  "cartpage"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        width: Dimensions.height20 * 5,
                                        margin: EdgeInsets.only(
                                            bottom: Dimensions.height10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstant.BASE_URL +
                                                        AppConstant.UPLOAD_URL +
                                                        cartController
                                                            .getItems[index]
                                                            .img!))),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.width10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            BigText(
                                              text: cartController
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(text: "Spicy"),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: cartController
                                                      .getItems[index].price
                                                      .toString(),
                                                  color: Colors.redAccent,
                                                ),

                                                // - 0  + button start fro here
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItems(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: AppColor
                                                              .signColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.width15 /
                                                                2,
                                                      ),
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()), //inCartItems.toString()),
                                                      SizedBox(
                                                        width:
                                                            Dimensions.width15 /
                                                                2,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItems(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColor
                                                              .signColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                    )),
              )): NoDataPage(text: "Your cart is empty!");
      })
        ],
      ),


      bottomNavigationBar:
              GetBuilder<CartController>(builder: (cartController) {
            return Container(
              height: Dimensions.bottomNevHeight,
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  color: AppColor.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: cartController.getItems.length >0 ?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(
                      children: [
                       
                        SizedBox(
                          width: Dimensions.width15 / 2,
                        ),
                        BigText(text: '\$ '+cartController.totalAmount.toString()),
                        SizedBox(
                          width: Dimensions.width15 / 2,
                        ),
                      
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //popularProduct.addItems(product);
                      if(Get.find<AuthController>().userLoggedIn()){
                      print("tapped");

                      //CartController.addtoCartHistory();
                        if(Get.find<LocationController>().addressList.isEmpty){
                         var location = Get.find<LocationController>().getUserAddress();
                         var cart = Get.find<CartController>().getItems;
                         var user = Get.find<UserController>().userModel;

                         PlaceOrderBody placeOrder = PlaceOrderBody(
                             cart: cart,
                             orderAmount: 100.0,
                             distance: 10.0,
                             scheduleAt:'' ,
                             orderNote: 'note about the food',
                             address: location.address,
                             latitude: location.latitude,
                             longitude: location.longitude,
                             contactPersonNumber: user!.phone,
                             contactPersonName: user!.name,

                         );
                          Get.find<OrderController>().placeOrder(
                            placeOrder,
                              _callBack
                          );
                        }else{
                          //Get.offNamed(RouteHelper.getInitial());

                        }
                      }else{
                         Get.toNamed(RouteHelper.getSignin());
                      }

                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColor.mainColor),
                      child: BigText(
                        text: 'Check out',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ): Container()
            );
          },
              ));

    
  }

 void  _callBack(bool isSuccess, String message, String orderID){
 if(isSuccess){
   // Get.find<CartController>().clear();
   // Get.find<CartController>().removeCartSharedPreference();
   // Get.find<CartController>().addtoCartHistory();

   Get.offNamed(RouteHelper.getPaymentPage(orderID,Get.find<UserController>().userModel!.id));
 }else{
   showCustomSnackbar(message);
 }
  }
}
