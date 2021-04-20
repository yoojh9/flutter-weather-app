import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import '../utils/location_xy.dart';
import '../utils/location_helper.dart' as locationHelper;

class LocationInfo with ChangeNotifier {
  double _latitude;
  double _longitude;
  Placemark _address;
  bool _isUpdated = false;
  bool _isKor = false;
  int _x;
  int _y;

  get latitude => _latitude;
  get longitude => _longitude;

  get address {
    if(_address==null) return "현재위치";
    else if(_address.thoroughfare != null && _address.thoroughfare.isNotEmpty){
      return _address.thoroughfare;
    } else if(_address.subLocality != null && _address.subLocality.isNotEmpty){
      return _address.subLocality;
    } else if(_address.locality != null && _address.locality.isNotEmpty){
      return _address.locality;
    } else {
      return _address.name;
    }
  }

  get isUpdated => _isUpdated;
  get isKor => _isKor;
  get x => _x;
  get y => _y;


  Future<LocationInfo> getLocation() async {
    LocationData locationData = await locationHelper.getLocation();

    if (locationData == null) return null;

    List<Placemark> addressList = await locationHelper.getAddress(locationData.latitude, locationData.longitude);
    LocationXY locationXY = changeGridLocation(locationData.longitude, locationData.latitude);

    print(addressList?.first);

    _latitude = locationData.latitude;
    _longitude = locationData.longitude;
    _address = addressList?.first;
    _x = locationXY.x;
    _y = locationXY.y;

    _isUpdated = true;

    if(_address == null || _address.isoCountryCode == null || _address.isoCountryCode != "KR"){
      _isKor = false;
    } else {
      _isKor = true;
    }

    notifyListeners();

    return this;
  }
}
