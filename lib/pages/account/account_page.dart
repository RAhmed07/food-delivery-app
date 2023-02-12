import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/Controllers/location_controller.dart';
import 'package:food_delivery_app/Controllers/user_controller.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("user has logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        centerTitle: true,
        title: BigText(
          text: "Profile",
          color: Colors.white,
          size: 24,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoadding?
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(
            children: [
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColor.mainColor,
                iconColor: Colors.white,
                size: Dimensions.height15 * 10,
                iconSize: Dimensions.height15 * 5,
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColor.mainColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: userController.userModel!.name,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.phone,
                          backgroundColor: AppColor.yellowColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: userController.userModel!.phone,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.email,
                          backgroundColor: AppColor.yellowColor,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: userController.userModel!.email,
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                     GetBuilder<LocationController>(builder: (locationController){
                       if(_userLoggedIn && locationController.addressList.isEmpty ){
                         return  GestureDetector(
                           onTap: (){
                             Get.toNamed(RouteHelper.getAddressPage());
                           },
                           child: AccountWidget(
                             appIcon: AppIcon(
                               icon: Icons.location_on,
                               backgroundColor: AppColor.yellowColor,
                               iconColor: Colors.white,
                               size: Dimensions.height10 * 5,
                               iconSize: Dimensions.height10 * 5 / 2,
                             ),
                             bigText: BigText(
                               text: "Fill in the address",
                             ),
                           ),
                         );
                       }else{
                         return  GestureDetector(
                           onTap: (){
                             Get.toNamed(RouteHelper.getAddressPage());
                           },
                           child: AccountWidget(
                             appIcon: AppIcon(
                               icon: Icons.location_on,
                               backgroundColor: AppColor.yellowColor,
                               iconColor: Colors.white,
                               size: Dimensions.height10 * 5,
                               iconSize: Dimensions.height10 * 5 / 2,
                             ),
                             bigText: BigText(
                               text: "Your address",
                             ),
                           ),
                         );

                       }
                     }),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AccountWidget(
                        appIcon: AppIcon(
                          icon: Icons.message_rounded,
                          backgroundColor: Colors.redAccent,
                          iconColor: Colors.white,
                          size: Dimensions.height10 * 5,
                          iconSize: Dimensions.height10 * 5 / 2,
                        ),
                        bigText: BigText(
                          text: "Messages",
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(Get.find<AuthController>().userLoggedIn()){
                            Get.find<AuthController>().clearSharedData();
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.find<LocationController>().clearAddressList();
                            Get.toNamed(RouteHelper.getSignin());

                          }else{
                            showCustomSnackbar("you must have login first",);
                          }
                        },
                        child: AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.logout,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            size: Dimensions.height10 * 5,
                            iconSize: Dimensions.height10 * 5 / 2,
                          ),
                          bigText: BigText(
                            text: "Logout",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ):CustomLoader()):
        Container(child: Center(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.maxFinite,
              height: Dimensions.height20*8,
              margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("lib/images/signintocontinue.png"))
              ),
            ),

            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getSignin());
              },
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height20*4,
                margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),

                ),
                child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,),),
              ),
            )
          ],
        )),);
      })
    );
  }
}
