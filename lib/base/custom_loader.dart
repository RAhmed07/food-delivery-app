import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("i am printing loading state "+Get.find<AuthController>().isLoadding.toString());
    return Center(
      child: Container(

        height: Dimensions.height20*5,
        width: Dimensions.width20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColor.mainColor

        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
