import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';

import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  String page;
   RecommendedFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Center(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: Dimensions.height10*7,
                title: Row(
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
                        child: AppIcon(icon: Icons.clear)),
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
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>CartPage());
                              },
                              child: AppIcon(icon: Icons.shopping_cart_outlined),
                            ),
                            Get.find<PopularProductController>().totalItems >= 1
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
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(Dimensions.height30),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height10/2, bottom: Dimensions.height10),
                    child: Center(
                      child: BigText(
                        size: Dimensions.font26,
                        text: product.name!,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius20),
                            topRight: Radius.circular(Dimensions.radius20))),
                  ),
                ),
                expandedHeight: Dimensions.height30*10,
                backgroundColor: AppColor.yellowColor,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    AppConstant.BASE_URL +
                        AppConstant.UPLOAD_URL +
                        product.img!,
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: ExpandadTextWidget(text: product.description!),
                  )
                ],
              ))
            ],
          ),

          //BottomNevBar
          bottomNavigationBar: GetBuilder<PopularProductController>(
            builder: ((controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Calculate how many product you buy and it's price
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20 * 2,
                        right: Dimensions.width20 * 2,
                        top: Dimensions.height10,
                        bottom: Dimensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.setQuentity(false);
                          },
                          child: AppIcon(
                            icon: Icons.remove,
                            iconSize: Dimensions.iconSize24,
                            iconColor: Colors.white,
                            backgroundColor: AppColor.mainColor,
                          ),
                        ),
                        BigText(
                            size: Dimensions.font26,
                            color: AppColor.mainBlackColor,
                            text:
                                '\$ ${product.price!} X  ${controller.inCartItems} '),
                        GestureDetector(
                          onTap: () {
                            controller.setQuentity(true);
                          },
                          child: AppIcon(
                            icon: Icons.add,
                            iconSize: Dimensions.iconSize24,
                            iconColor: Colors.white,
                            backgroundColor: AppColor.mainColor,
                          ),
                        )
                      ],
                    ),
                  ),

                  //Add to Cart

                  Container(
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
                            topRight:
                                Radius.circular(Dimensions.radius20 * 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.all(Dimensions.height20),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white),
                            child: Icon(
                              Icons.favorite,
                              color: AppColor.mainColor,
                            )),
                        GestureDetector(
                          onTap: (() {
                            controller.addItems(product);
                          }),
                          child: Container(
                              padding: EdgeInsets.all(Dimensions.height20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: AppColor.mainColor),
                              child: BigText(
                                text: '\$ ${product.price!} | Add to cart',
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
