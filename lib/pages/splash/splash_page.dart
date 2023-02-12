


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation <double> animation;
  late AnimationController controller;
   Future<void>_loadResource() async{
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>().getRecommendedProductList();
  }


  @override
  void initState() {
    _loadResource();
    
    super.initState();
    controller = AnimationController(vsync: this,duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
     Timer( const Duration(seconds: 3), ()=> Get.toNamed(RouteHelper.getInitial()));
  }
  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          ScaleTransition(
            scale: animation,
            child:  Center(
              child: Image(
                width: Dimensions.splashImg,
                image: const AssetImage('lib/images/logo part 1.png') ,),
            ),
          ),
           Center(
            child: Image(
              width: Dimensions.splashImg,
              image:const  AssetImage('lib/images/logo part 2.png') ,),
          ),
        ],
      ),
    );
  }
}