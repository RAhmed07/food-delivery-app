// import 'package:get/get.dart';
// class Dimensions{
// static double screenHeight = Get.context!.height;
// static double screenWidth = Get.context!.width;
// static double pageViewContainer = screenHeight/3.62;
// static double pageViewTextContainer = screenHeight/6.13;
// static double pageView = screenHeight/2.49;
//
// static double height10 = screenHeight/79.7;
// static double height15 = screenHeight/53.13;
// static double height20 = screenHeight/39.85;
// static double height30 = screenHeight/26.57;
// static double height45 = screenHeight/17.71;
//
//
// static double width10 = screenHeight/79.7;
// static double width15 = screenHeight/53.13;
// static double width20 = screenHeight/39.85;
// static double width30 = screenHeight/26.57;
// static double width45 = screenHeight/17.71;
//
// static double font26 = screenHeight/30.6538;
// static double font20 = screenHeight/42.2;
// static double font16 = screenHeight/49.8125;
// static double font12 = screenHeight/66.42;
//
// static double radius15 = screenHeight/53.13;
// static double radius20 = screenHeight/39.85;
// static double radius30 = screenHeight/26.57;
//
// static double iconSize24 = screenHeight/33.20;
// static double iconSize16 = screenHeight/49.8125;
//
// static double listViewImgSize = screenWidth/3.425;
// static double listViewContSize = screenWidth/4.11;
//
// static double popularFoodImgSize = screenHeight/2.28;
//
//
// //bottomNevHeight
// static double bottomNevHeight = screenHeight/6.64;
//
// //Splash page Height
// static double splashImg = screenHeight/3.188;
//
//
//
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dimensions{
  static double screenHeight = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  static double screenWidth = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.width;

  


static double pageViewContainer = screenHeight/3.62;
static double pageViewTextContainer = screenHeight/6.13;
static double pageView = screenHeight/2.49;

static double height10 = screenHeight/79.7;
static double height15 = screenHeight/53.13;
static double height20 = screenHeight/39.85;
static double height30 = screenHeight/26.57;
static double height45 = screenHeight/17.71;


static double width10 = screenHeight/79.7;
static double width15 = screenHeight/53.13;
static double width20 = screenHeight/39.85;
static double width30 = screenHeight/26.57;
static double width45 = screenHeight/17.71;

static double font26 = screenHeight/30.6538;
static double font20 = screenHeight/42.2;
static double font16 = screenHeight/49.8125;
static double font12 = screenHeight/66.42;

static double radius15 = screenHeight/53.13;
static double radius20 = screenHeight/39.85;
static double radius30 = screenHeight/26.57;

static double iconSize24 = screenHeight/33.20;
static double iconSize16 = screenHeight/49.8125;

static double listViewImgSize = screenWidth/3.425;
static double listViewContSize = screenWidth/4.11;

static double popularFoodImgSize = screenHeight/2.28;


//bottomNevHeight
static double bottomNevHeight = screenHeight/6.64;

//Splash page Height
static double splashImg = screenHeight/3.188;
}