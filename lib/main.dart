

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/popular_product_controller.dart';
import 'package:food_delivery_app/Controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/account/account_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/cart/cart_history.dart';

import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recommended_food_details.dart';
import 'package:food_delivery_app/helper/dependencies.dart' as dep;
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/color.dart';


import 'package:get/get.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await dep.init();
 
  
  runApp( const MyApp());

  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
  
    return GetBuilder<PopularProductController>(
      builder: (_) {
         return GetBuilder<RecommendedProductController>(
          builder: (_) {
             return  GetMaterialApp(
                
                 debugShowCheckedModeBanner: false,
                 //home: SignInPage(),
                 
                initialRoute: RouteHelper.getSplashPage(),
                getPages: RouteHelper.routes,
               theme: ThemeData(
                 primaryColor: AppColor.mainColor,
                 fontFamily: 'San Sarif'
               )

                
               );
            
          },
          
         );
      },
     
    );
  }
}

