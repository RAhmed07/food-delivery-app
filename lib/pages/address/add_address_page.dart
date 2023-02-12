import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/auth_controller.dart';
import 'package:food_delivery_app/Controllers/location_controller.dart';
import 'package:food_delivery_app/Controllers/user_controller.dart';
import 'package:food_delivery_app/models/addressModel.dart';
import 'package:food_delivery_app/pages/address/pick_address_map.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController =TextEditingController();
  final TextEditingController _contactPersonName =TextEditingController();
  final TextEditingController _contactPersonNumber =TextEditingController();
  late bool _isLogged;
   CameraPosition _cameraPosition =const CameraPosition(target: LatLng(
    45.51563,-122.677433
  ),zoom: 17);
  late LatLng _initialPosition = LatLng(
      45.51563,-122.677433
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      /*
      bug fix
      */
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==""){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));

      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        title: Text("Address"),
        centerTitle: true,

      ),
      body: GetBuilder<UserController>(builder:(userController){
        if(userController.userModel!=null && _contactPersonName.text.isEmpty){
          _contactPersonName.text = '${userController.userModel?.name}';
          _contactPersonNumber.text = '${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty){
             _addressController.text =Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text = '${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("address in my view is"+_addressController.text);

          return SingleChildScrollView(
            //physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5,right: 5,top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2,
                          color: AppColor.mainColor
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(

                        initialCameraPosition:
                        CameraPosition(target: _initialPosition,zoom: 17),
                        onTap: (latLng){
                          Get.toNamed(RouteHelper.getPickAddressPage(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,

                            )
                          );

                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position)=>_cameraPosition =position),

                        onMapCreated: (GoogleMapController controller){
                          locationController.setMapController(controller);

                        },
                      )
                    ],
                  ),
                ),

                Padding(

                  padding:  EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                  child: SizedBox(height: 50,child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                              margin: EdgeInsets.only(right: Dimensions.width20/2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                  color: Theme.of(context).cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        color: Colors.grey[200]!
                                    )
                                  ]
                              ),
                              child: Icon(
                                index==0?Icons.home_filled:index==1?Icons.work:Icons.location_on,
                                color: locationController.addresTypeIndex==index?AppColor.mainColor:Theme.of(context).disabledColor,
                              )

                          ),

                        );
                      }),),
                ),
                SizedBox(height:Dimensions.height20,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height:Dimensions.height10,),
                AppTextField(textEditingController: _addressController, hintText: "Your address", icon: Icons.map),
                SizedBox(height:Dimensions.height10,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: "Contact name"),
                ),
                SizedBox(height:Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                SizedBox(height:Dimensions.height10,),
                Padding(
                  padding:  EdgeInsets.only(left: Dimensions.height20),
                  child: BigText(text: "Your number"),
                ),
                SizedBox(height:Dimensions.height10,),
                AppTextField(textEditingController: _contactPersonNumber, hintText: "Your phone", icon: Icons.phone)

              ],
            ),
          );
        });
      }),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: ((locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Calculate how many product you buy and it's price


              //Add to Cart

              Container(
                height: Dimensions.bottomNevHeight,
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    color: AppColor.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight:
                        Radius.circular(Dimensions.radius20 * 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    GestureDetector(
                      onTap: (() {
                     AddressModel _addressModel =  AddressModel(
                       addressType: locationController.addressTypeList[locationController.addresTypeIndex],
                       contactPersonName: _contactPersonName.text,
                       contactPersonNumber: _contactPersonNumber.text,
                       address: _addressController.text,
                       latitude: locationController.position.latitude.toString(),
                       longitude: locationController.position.longitude.toString()
                     );
                     locationController.addAddress(_addressModel).then((response){
                       if(response.isSuccess){
                         Get.toNamed(RouteHelper.getInitial());
                         Get.snackbar("Address", "Added successfully");
                       }else{
                         Get.snackbar("Address", "Couldn't save address");
                       }
                     });
                      }),
                      child: Container(
                          padding: EdgeInsets.all(Dimensions.height20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radius20),
                              color: AppColor.mainColor),
                          child: BigText(
                            text: 'Save address',
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),

    );
  }
}
