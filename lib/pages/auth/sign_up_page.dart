
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/color.dart';

import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages =[
      "g.png",
      "f.png",
      "t.png"
    ];

    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
    showCustomSnackbar("Type in your name",title: "Name");
      }else if (phone.isEmpty){
        showCustomSnackbar("Type in your phone number",title: "Phone");
      }else if(email.isEmpty){
        showCustomSnackbar("Type in your email",title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Type in a valid email address",title: "Valid email address");
      }else if(password.isEmpty){
        showCustomSnackbar("Type in your password",title: "password");
      }else if(password.length<6){
        showCustomSnackbar("Password can not be less then 6 character",title: "Password");
      }else{

        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
       authController.registration(signUpBody).then((status) {
         if(status.isSuccess==true){
           print("Success Registration");
         }else{
           print("hey error!");
           showCustomSnackbar(status.message);
         }
       } );
      }

    }

    return Scaffold(



      backgroundColor: Colors.white,
      body:  GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoadding?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(

            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.radius20*4,
                    backgroundImage: AssetImage("lib/images/logo part 1.png"),
                  ),
                ),
              ),
              //Email
              AppTextField(textEditingController: emailController, hintText: "Email", icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //Password
              AppTextField(textEditingController: passwordController, isObscure: true, hintText: "Password", icon: Icons.password_outlined),
              SizedBox(height: Dimensions.height20,),
              //Name
              AppTextField(textEditingController: nameController, hintText: "Name", icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              //phone
              AppTextField(textEditingController: phoneController, hintText: "Phone", icon: Icons.phone),
              SizedBox(height: Dimensions.screenHeight*0.05,),

              GestureDetector(
                onTap: (){
                  _registration(_authController);
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColor.mainColor
                  ),
                  child: Center(child: BigText(text: "Sign up",color: Colors.white,size: Dimensions.font20+Dimensions.font20/2,)),
                ),
              ),
              SizedBox(height: Dimensions.height10,),
              RichText(text: TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                  text: "Have an account already?",
                  style:TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                  )
              )),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              RichText(text: TextSpan(

                  text: "Sign up using one of the following method",
                  style:TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16
                  )
              )),
              Wrap(

                  children: List.generate(3, (index) => Padding(
                    padding:  EdgeInsets.all(Dimensions.width15),

                    child: CircleAvatar(

                        radius: Dimensions.radius20,
                        backgroundImage: AssetImage("lib/images/"+signUpImages[index])
                    ),
                  ))
              )


            ],
          ),
        ):const CustomLoader();
      })

    );
  }
}
