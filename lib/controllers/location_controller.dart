// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_Satya/data/api/api_checker.dart';
import 'package:project_Satya/data/repository/location_repo.dart';
import 'package:project_Satya/models/response_model.dart';
import '../models/address_model.dart';
// ignore: depend_on_referenced_packages, implementation_imports
import 'package:google_maps_webservice/src/places.dart';

class LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = const Placemark();
  Placemark _pickPlacemark = const Placemark();
  Placemark get placemark=>_placemark;
  Placemark get pickPlacemark=> _pickPlacemark;
  List <AddressModel> _addressList=[];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList=>_allAddressList;
  final List<String> _addressTypeList=["home", "office", "others"];
  List <String> get addressTypeList=>_addressTypeList;
  int _addressTypeIndex=0;
  int get addressTypeIndex => _addressTypeIndex;


  late GoogleMapController _mapController;
  GoogleMapController get mapController=>_mapController;

  bool _updateAddressData=true;
  bool _changeAddress=true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  /*
  for service zone
   */
  bool _isLoading = false;
  bool get isLoading=>_isLoading;
  /*
  whether the user is in service zone or not
   */
  bool _inZone = false;
  bool get inZone =>_inZone;
  /*
  showing and hiding the button as map loads
   */
  bool _buttonDisabled=true;
  bool get buttonDisabled => _buttonDisabled;

  /*
  save the google map suggestion for address
   */
 List<Prediction> _predictionList= [];

 /*
 debug purpose
  */
  Future<void> getCurrentLocation(bool fromAddress,
  {required GoogleMapController mapController,
  LatLng? defaultLatLng, bool notify = true}) async {
    _isLoading = true;
    if(notify){
      update();
    }
  }

  void setMapController (GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if(_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          var headingAccuracy;
          _position= Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1,
            altitudeAccuracy: 1.0, headingAccuracy: headingAccuracy,
          );
        }else{
          _pickPosition=Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1.0, headingAccuracy: 1.0,

          );
        }

        ResponseModel responseModel =
            await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        /*
        if button value is false we are in the service area;
         */
        _buttonDisabled = !responseModel.isSuccess;
        if(_changeAddress){
          String address = await getAddressfromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude
            )
          );
          fromAddress?_placemark=Placemark(name: address):
          _pickPlacemark=Placemark(name: address);

        }else{
          _changeAddress =true;
        }
      // ignore: empty_catches
      }catch(e){
      }
      _loading=false;
      update();
    }else{
      _updateAddressData=true;
    }
  }


  Future<String> getAddressfromGeocode(LatLng latlng) async {
    String address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latlng);
    if (response.body["status"]=='OK'){
      address = response.body["results"][0]['formatted_address'].toString();
      //print("Printing Address "+_address);

    }else{
    }
      update();
    return address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress=>_getAddress;

  AddressModel getUserAddress(){
    late AddressModel addressModel;
    /*
    converting map using jsonDecode
     */
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
        addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    // ignore: empty_catches
    }catch(e){
    }
    return addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }

  Future<ResponseModel>addAddress(AddressModel addressModel) async {
    _loading=true;
    update();
    Response response=await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    }else{
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();
    if(response.statusCode==200){
      _addressList=[];
      _allAddressList=[];
      response.body.forEach((address){
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    }else{
      _addressList=[];
      _allAddressList=[];
    }
    update();
  }
  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }
  void clearAddressList(){
    _addressList=[];
    _allAddressList=[];
    update();
  }

  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
    _position=_pickPosition;
    _placemark=_pickPlacemark;
    _updateAddressData=false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel responseModel;
    if(markerLoad){
      _loading=true;
    }else{
      _isLoading=true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if(response.statusCode==200){
    _inZone=true;
    responseModel = ResponseModel(true, response.body["zone_id"].toString());
    }else{
      _inZone=false;
      responseModel = ResponseModel(true, response.statusText!);
    }
    if(markerLoad){
      _loading=false;
    }else{
      _isLoading=false;
    }

    //print("Zone response code is "+response.statusCode.toString());//200, //404, //500

    update();
    return responseModel;
  }

  Future<List<Prediction>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty){
      Response response = await locationRepo.searchLocation(text);
      if(response.statusCode==200&&response.body['status']=='OK'){
        _predictionList=[];
        response.body['predictions'].forEach((prediction)
        =>_predictionList.add(Prediction.fromJson(prediction)));
      }else{
        ApiChecker.checkApi(response);
      }
    }
    return _predictionList;
  }
  setLocation(String placeID, String address, GoogleMapController mapController) async {
    _loading=true;
    update();
    PlacesDetailsResponse detail;
    Response response = await locationRepo.setLocation(placeID);
    detail = PlacesDetailsResponse.fromJson(response.body);
    _pickPosition = position;
    _pickPlacemark = Placemark(name:address);
    _changeAddress = false;
    // ignore: deprecated_member_use
    if(!mapController.isNull){
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(
          detail.result.geometry!.location.lat,
          detail.result.geometry!.location.lng,
        ), zoom: 17)
      ));
    }
    _loading = false;
    update();
  }
}
