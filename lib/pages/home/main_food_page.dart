import 'package:flutter/material.dart';

import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';


import '../../Controllers/popular_product_controller.dart';
import '../../Controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}



class _MainFoodPageState extends State<MainFoodPage>  {


  Future<void> _loadResource() async {


    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();


  }


  @override
  Widget build(BuildContext context) {




    return RefreshIndicator(
      
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: Dimensions.height15*4, bottom: Dimensions.height15),
          padding: EdgeInsets.only(
              right: Dimensions.width15, left: Dimensions.width15),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                      text: 'Bangladesh',
                      color: AppColor.mainColor,
                    ),
                    Row(
                      children: [
                        SmallText(
                          text: 'Narsingdi',
                          color: Colors.black54,
                        ),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: Dimensions.height45,
                    width: Dimensions.width45,
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimensions.iconSize24,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius15),
                        color: AppColor.mainColor),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(child: FoodPageBody()),
        ),
      ],
    ),
        onRefresh: _loadResource);
  }
}
