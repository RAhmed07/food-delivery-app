import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constant.dart';

import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController _pageController = PageController(viewportFraction: 0.85);
  double _scaleFactor = 0.80;
  var height = Dimensions.pageViewContainer;
  //Current page value
  var _currPageValue = 0.0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // _buildpageItem Function() work

  Widget _buildPageItem(int index, Productmodel popularProduct) {
    // Scaling dart code
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - currScale) / 2, 0);
    }

    // Scaling dart code end

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index,"home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstant.BASE_URL +
                        AppConstant.UPLOAD_URL+popularProduct.img!)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                 
                  boxShadow: const [
                     BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5,
                        offset: Offset(0, 5)),
                     BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                     BoxShadow(color: Colors.white, offset: Offset(-5, 0))
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  child: AppColumn(
                    text: popularProduct.name!,
                  ) //App column class into (wiged folder)
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ?  SizedBox(
                  // color: Colors.red,
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      itemCount: popularProducts.popularProductList.length,
                      controller: _pageController,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColor.mainColor,
                );
        }),
    
        // Dots Indecator section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColor.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
    
        // Recommended section
    
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: 'Recommended'),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: 'Food pairing'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        //List of Food and images
        
        // Recommended section
    
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded?ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: recommendedProduct.recommendedProductList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (() {
                    Get.toNamed(RouteHelper.getrecommendedFood(index,"home"));
                  }),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width20,
                        right: Dimensions.width20,
                        bottom: Dimensions.height10),
                    child: Row(
                      children: [
                        Container(
                          height: Dimensions.listViewImgSize,
                          width: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image:  DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstant.BASE_URL +
                        AppConstant.UPLOAD_URL +
                        recommendedProduct.recommendedProductList[index].img!))),
                        ),
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewContSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight:
                                        Radius.circular(Dimensions.radius20),
                                    bottomRight:
                                        Radius.circular(Dimensions.radius20)),
                                color: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Dimensions.width10,
                                  right: Dimensions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProduct.recommendedProductList[index].name),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(
                                      text: ' With chineses characteristics'),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconAndText(
                                          icon: Icons.circle_sharp,
                                          text: 'Normal',
                                          iconColor: AppColor.iconColor1),
                                      IconAndText(
                                          icon: Icons.location_on,
                                          text: '1.7km',
                                          iconColor: AppColor.mainColor),
                                      IconAndText(
                                          icon: Icons.access_time_rounded,
                                          text: '32min',
                                          iconColor: AppColor.iconColor2),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }):CircularProgressIndicator(color: AppColor.mainColor,);
        })
      ],
    );
  }
}
