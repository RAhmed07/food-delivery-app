import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/account/account_page.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/pages/cart/cart_history.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';

import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/order/order_page.dart';
import 'package:food_delivery_app/utils/color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {


  int _selectedIndex = 0;
List pages =[
  MainFoodPage(),
  Center(child: Container(child: Text("Archive"),),),
  OrderPage(),
  AccountPage()
];

void _onTabNav(int index){
  setState((){
    _selectedIndex = index;

  });
 
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.mainColor,
      currentIndex: _selectedIndex,
      onTap: _onTabNav,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'Archive'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Me'),
      ]),
    );
  }
}