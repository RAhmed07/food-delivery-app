import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/location_controller.dart';
import 'package:food_delivery_app/base/custom_button.dart';
import 'package:food_delivery_app/pages/address/widges/search_loction_dialogue_page.dart';
import 'package:food_delivery_app/utils/color.dart';
import 'package:food_delivery_app/utils/dimension.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(
                Get.find<LocationController>().getAddress["longitude"]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                       _mapController =mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "lib/images/pick_marker.png",
                            height: Dimensions.height10 * 5,
                            width: Dimensions.height10 * 5,
                          )
                        : CircularProgressIndicator(),
                  ),
                  /*
                  showing and selecting address
                   */
                  Positioned(
                    top: Dimensions.height45,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: InkWell(
                      onTap: ()=> Get.dialog(LocationDialogue(mapController: _mapController)),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20 / 2),
                        height: Dimensions.height10 * 5,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 25,
                              color: AppColor.yellowColor,
                            ),
                            Expanded(
                              child: Text(
                                  locationController.pickPlacemark.name ?? '',
                                  style: TextStyle(
                                      fontSize: Dimensions.font16,
                                      color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),


                            ),
                            SizedBox(width: Dimensions.width10,),
                             Icon(Icons.search,size: 25,color:AppColor.yellowColor,)


                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,


                      child:  locationController.isLoading?const Center(child: CircularProgressIndicator(),):CustomButton(
                        buttonText: locationController.inZone?widget.fromAddress?'Pick address':'Pick Location':"Service is not available",
                        onPressed: (locationController.buttonDisabled||locationController.loading)?null:(){
                          if(locationController.pickPosition.latitude!=0 && locationController.pickPlacemark.name!=null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print("you clicked on this");
                                widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                                    locationController.pickPosition.latitude,
                                    locationController.pickPosition.longitude
                                ))));
                                locationController.setAddAddressData();
                              }
                              Get.toNamed(RouteHelper.getAddressPage());
                            }
                          }
                        },

                      ),


                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
