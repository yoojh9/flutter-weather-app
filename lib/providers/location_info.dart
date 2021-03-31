import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import '../utils/location_helper.dart' as locationHelper;

class LocationInfo with ChangeNotifier{
  double _latitude;
  double _longitude;
  Address _address;
  bool _isUpdated = false;

  get latitude => _latitude;
  get longitude => _longitude;
  get address => _address.subLocality == null ? _address.featureName : _address.subLocality;
  get isUpdated => _isUpdated;

  // LocationInfo(){
  //   getLocation().then((_){
  //     notifyListeners();
  //   });
  // }

  Future<LocationInfo> getLocation() async{

    LocationData locationData = await locationHelper.getLocation();
    List<Address> addressList = await locationHelper.getAddress(locationData.latitude, locationData.longitude);

    print('locationData : $locationData');
    print('address : ${addressList[0]}');
    print('address.feature ${addressList[0].subLocality}');
    _latitude = locationData.latitude;
    _longitude = locationData.longitude;
    _address = addressList[0];
    _isUpdated = true;

    notifyListeners();

    return this;

  }
}