import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/Data/api/api_checker.dart';
import 'package:food_delivery_app/Data/repository/location_rapo.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/addressModel.dart';
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loadding =false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark =Placemark();
  Placemark _pickPlacemark=Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark=> _pickPlacemark;
  List<AddressModel> _addressList =[];
  List<AddressModel> get addressList =>_addressList;
  late List <AddressModel> _allAddressList;
  List <AddressModel>  get allAddressList  => _allAddressList;
  List<String> _addressTypeList =["home","office","others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex =0;
  int get addresTypeIndex => _addressTypeIndex;



  late GoogleMapController _mapController;

   GoogleMapController get mapController => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = false;

  bool get loading => _loadding;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  /*
  for service zone
  */
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /*
  whether the user is in service zone or not
  */

  bool _inZone = false;
  bool get inZone => _inZone;

  /*
  showing and hiding button as the map loads
  */

  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  /*
  save the google map suggestions for address
  */
  List <Prediction> _predictionList=[];


  void setMapController(GoogleMapController mapController){
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async{
    if(_updateAddressData){
      _loadding =true;
      update();
      try{
        if(fromAddress){
          _position = Position(
              longitude: position.target.longitude ,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy:1);

        }else{
          _pickPosition = Position(
              longitude: position.target.longitude ,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy:1);

        }

        ResponseModel _responseModel =
            await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        /*
        if the button value is false we are in service area
        */
          _buttonDisabled=!_responseModel.isSuccess;

        if(_changeAddress){
          String _address = await  getAddressFromGeocode(
            LatLng(position.target.latitude, position.target.longitude)
          );

          fromAddress? _placemark=Placemark(name:_address):_pickPlacemark=Placemark(name:_address);

        }else{
          _changeAddress =true;
        }
        _loadding =false;

      }catch(e){
        print(e);
      }
    }else{
      _updateAddressData =true;
    }
  }
 Future<String>  getAddressFromGeocode(LatLng latLng) async{
    String _address = "Unknown location Found";
    Response response = await locationRepo.getAddressFromGeocode(latLng);
    if(response.body["status"]=='OK'){
      _address = response.body["results"][0]['formatted_address'].toString();

     // print("printing location"+_address);
    }else{
      print("error getting the google api");
    }
    update();
    return _address;
 }

  late Map <String,dynamic> _getAddress;
  Map get getAddress => _getAddress;

 AddressModel getUserAddress(){
   late AddressModel _addressModel;
//converting to map using json decode
   _getAddress = json.decode(locationRepo.getUserAddress());
   try{
     _addressModel = AddressModel.fromJson(json.decode(locationRepo.getUserAddress()));

   }catch(e){
     print(e);
   }
   return _addressModel;

 }

 setAddressTypeIndex( int index){
   _addressTypeIndex = index;
   update();
 }
 
 Future<ResponseModel> addAddress(AddressModel addressModel) async {
   _loadding = true;
   update();
   Response response = await locationRepo.addAddress(addressModel);
   ResponseModel responseModel;
   if(response.statusCode ==200){
     await getAllAddress();
     String message = response.body["message"];
     responseModel = ResponseModel(true, message);
     await saveUserAddress(addressModel);

   }else{
     print("Couldn't save the addresss");
         responseModel =ResponseModel(false, response.statusText!);
   }
   return responseModel;
 }

 Future<void> getAllAddress() async{
   Response response =  await locationRepo.getAllAddress();
   if(response.statusCode == 200){
     _addressList =[];
     _allAddressList =[];
     response.body.forEach((address){
       _addressList.add(AddressModel.fromJson(address));
       _allAddressList.add(AddressModel.fromJson(address));
     });
   }else{
     _addressList =[];
     _allAddressList =[];


   }
   update();
 }

  Future <bool> saveUserAddress(AddressModel addressModel) async {
  String userAddress = jsonEncode(addressModel.toJson());
  return await locationRepo.saveUserAddress(userAddress);

  }

  void clearAddressList(){
    _addressList =[];
    _allAddressList =[];
    update();
  }

  String getUserAddressFromLocalStorage(){
   return locationRepo.getUserAddress();

  }

  void setAddAddressData(){
   _position = _pickPosition;
   _placemark = _pickPlacemark;
   _updateAddressData = false;
   update();
  }


  Future<ResponseModel>getZone(String lat, String lng, bool markerLoad) async {
   late ResponseModel _responseModel;
   if(markerLoad){
     _loadding =true;
   }else{
     _isLoading = true;
   }
   update();

  Response response = await locationRepo.getZone(lat, lng);
  if(response.statusCode ==200){
    _inZone =true;
    _responseModel = ResponseModel(true, response.body["zone_id"].toString());

  }else{
    _inZone =false;
    _responseModel = ResponseModel(true, response.statusText!);
  }
  print("Status Code is "+response.statusCode.toString());

   if(markerLoad){
     _loadding =false;
   }else{
     _isLoading = false;
   }

   update();
   return _responseModel;
  }

  Future <List<Prediction>>searchLocation(BuildContext context,String text) async {
   if(text.isNotEmpty){
     Response response = await locationRepo.searchLocation(text);
     if(response.statusCode ==200 && response.body['status']=='OK'){
       _predictionList =[];
       response.body['predictions'].forEach((prediction)
       =>_predictionList.add(Prediction.fromJson(prediction)));
     }else{
       ApiChecker.checkApi(response);

     }
   }
   return _predictionList;

  }

  setLocation(String placeID, String address,GoogleMapController mapController) async {
   _loadding =true;
   update();
   PlacesDetailsResponse details;
   Response response = await locationRepo.setLocation(placeID);
   details = PlacesDetailsResponse.fromJson(response.body);

   _pickPosition = Position(
       longitude: details.result.geometry!.location.lng,
       latitude: details.result.geometry!.location.lat,
       timestamp: DateTime.now(),
       accuracy: 1,
       altitude: 1,
       heading: 1,
       speed: 1,
       speedAccuracy: 1);
   _placemark = Placemark(name: address);
   _changeAddress = false;
   if(!mapController.isNull){
     mapController.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(target: LatLng(
         details.result.geometry!.location.lat,
         details.result.geometry!.location.lng
       ),zoom: 17)
     ));
   }
   _loadding = false;
   update();

  }

}