import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';

import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  String page;
  PopularFoodDetail({Key? key, required this.pageId,required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return SafeArea(
      child: Scaffold(
           
          body: Stack(children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: Dimensions.popularFoodImgSize,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(AppConstant.BASE_URL +
                              AppConstant.UPLOAD_URL +
                              product.img!))),
                )),
            Positioned(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (() {
                          if(page=="cartpage"){
                         Get.toNamed(RouteHelper.cartPage);
                          }else{
                            Get.toNamed(RouteHelper.getInitial());
                          }
                        }),
                        child: AppIcon(icon: Icons.arrow_back_ios)),
      
                    //Add shopping cart
                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap: () {
      
                          if(controller.totalItems >= 1){
                            Get.toNamed(RouteHelper.cartPage);
      
                          }
                          
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            controller.totalItems >= 1
                                ? Positioned(
                                    top: -Dimensions.height10/2,
                                    right: -Dimensions.height10/2,
                                    child: CircleAvatar(
                                      radius: Dimensions.radius20/2,
                                      backgroundColor: AppColor.mainColor,
                                      child: BigText(
                                        text: Get.find<PopularProductController>()
                                            .totalItems
                                            .toString(),
                                        size: Dimensions.font12,
                                        color: Colors.white,
                                      ),
                                    ))
                                : Container(),
                          ],
                        ),
                      );
                    })
                  ],
                )),
            Positioned(
                top: Dimensions.popularFoodImgSize - Dimensions.height20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        top: Dimensions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppColumn(
                          text: product.name!,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        BigText(text: 'Introduce'),
                        SizedBox(
                          height: Dimensions.font20,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                                child: ExpandadTextWidget(
                                    text: product.description!)))
                      ],
                    )))
          ]),
          bottomNavigationBar:
              GetBuilder<PopularProductController>(builder: (popularProduct) {
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
              child: Row(
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
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuentity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColor.signColor,
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width15 / 2,
                        ),
                        BigText(text: popularProduct.inCartItems.toString()),
                        SizedBox(
                          width: Dimensions.width15 / 2,
                        ),
                        GestureDetector(
                          onTap: () {
                            popularProduct.setQuentity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColor.signColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      popularProduct.addItems(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColor.mainColor),
                      child: BigText(
                        text: '\$ ${product.price!} | Add to cart',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },),),
    );
  }
}
