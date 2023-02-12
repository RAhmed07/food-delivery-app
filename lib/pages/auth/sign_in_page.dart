import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/utils/color.dart';

import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controllers/auth_controller.dart';
import '../../base/show_custom_snackbar.dart';
import '../../routes/route_helper.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login (AuthController authController){

      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty){
        showCustomSnackbar("Type in your email",title: "Email");
      }else if(!GetUtils.isEmail(phone)){
        showCustomSnackbar("Type in a valid email address",title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackbar("Type in your password",title: "password");
      }else if(password.length<6){
        showCustomSnackbar("Password can not be less then 6 character",title: "Password");
      }else{


        authController.login(phone,password).then((status) {
          if(status.isSuccess){
           Get.toNamed(RouteHelper.getInitial());
          }else{
            print("hey error!");
            showCustomSnackbar(status.message);
          }
        } );
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoadding?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                height: Dimensions.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20 * 4,
                    backgroundImage: AssetImage("lib/images/logo part 1.png"),
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,


                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize:
                          Dimensions.font20 * 3 + Dimensions.font20 / 2,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20, color: Colors.grey[500]),
                    )
                  ],
                ),
              ),


              SizedBox(
                height: Dimensions.screenHeight*0.05,
              ),
              //Email
              AppTextField(
                  textEditingController: phoneController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(
                height: Dimensions.height20,
              ),
              //Password
              AppTextField(
                  textEditingController: passwordController,
                  hintText: "Password",
                  isObscure: true,
                  icon: Icons.password_outlined),
              SizedBox(
                height: Dimensions.height20,
              ),
              //Name

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //phone
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.width20),
                    child: RichText(
                        text: TextSpan(
                            text: "Sign into your account",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font16))),
                  ),
                ],
              ),

              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),

              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColor.mainColor),
                  child: Center(
                      child: BigText(
                        text: "Sign up",
                        color: Colors.white,
                        size: Dimensions.font20 + Dimensions.font20 / 2,
                      )),
                ),
              ),

              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage(),transition: Transition.fade),
                        text: "Create",
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
