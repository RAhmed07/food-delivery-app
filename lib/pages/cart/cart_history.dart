import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/cart_controller.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/app_constant.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

   Map<String, int> cartItemsPerOrder =   Map();
  
  for(int i = 0; i<getCartHistoryList.length; i++){
    if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
      cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=> ++value);
      
    }else{
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!,()=> 1);
    }
  }
  List<int> cartItemsPerOrderToList(){
    return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    
   
  }
   List<String> cartOrderTimeToList(){
    return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    
   
  }
  
  List<int> itemsPerOrder = cartItemsPerOrderToList();
  print("total order in the history"+itemsPerOrder.toString());


  
  var ListCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColor.mainColor,
            height: Dimensions.height20*5,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History",color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconColor: AppColor.mainColor,)
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0? Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context, 
                child: ListView(
                children: [
                  for(int i =0; i< itemsPerOrder.length; i++)
                     Container(
                      height: Dimensions.height30*4,
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ((){
                          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[ListCounter].time!);
                          var inputDate = DateTime.parse(parseDate.toString());
                          var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                          var outputDate = outputFormat.format(inputDate);
                          return BigText(text: outputDate,);
                        }()),
                        SizedBox(height: Dimensions.height10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(itemsPerOrder[i], (index) {
                                if(ListCounter< getCartHistoryList.length){
                                  ListCounter++;
                                }
                                return index <=2 ? Container(
                                  height: Dimensions.height20*4,
                                  width: Dimensions.width20*4,
                                  margin: EdgeInsets.only(right: Dimensions.height10/2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                    
                                    image: DecorationImage(
                                      fit:BoxFit.cover,
                                      image: NetworkImage(AppConstant.BASE_URL+AppConstant.UPLOAD_URL+getCartHistoryList[ListCounter-1].img!))

                                  )
                                  
                                
                                ): Container();
                              }),
                            ),
                            Container(
                              height: Dimensions.height20*4,
                              //color: Colors.red,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SmallText(text: 'Total',color: AppColor.titleColor,),
                                  BigText(text: itemsPerOrder[i].toString()+' Items',color: AppColor.titleColor,),
                                  GestureDetector(
                                    onTap: (() {
                                      var orderTime = cartOrderTimeToList();
                                      Map<int, CartModel> moreOrder ={};
                                      for(int j=0; j< getCartHistoryList.length; j++){
                                        // ignore: unrelated_type_equality_checks
                                        if(getCartHistoryList[j].time == orderTime[i]){
                                          moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));

                                        }
                                      }
                                      Get.find<CartController>().setItems = moreOrder;
                                      Get.find<CartController>().addToCartList();
                                      Get.toNamed(RouteHelper.getCartPage());
                                      
                                    }),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                        border: Border.all(width: 1,color: AppColor.mainColor)
                                      ),
                                      child: SmallText(text: 'one more',color: AppColor.mainColor,),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                  
                 
                ],
                
              ),)
            ),
          ): SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
                child: Center(
                  child: NoDataPage(text: "You don't buy anything do far !",
                    imgPath: "lib/images/empty_box.png",),
                ));
          })
          
        ],
      ),
    );
  }
}





