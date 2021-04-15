import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import '../utils/location_xy.dart';
import '../utils/location_helper.dart' as locationHelper;

class LocationInfo with ChangeNotifier {
  double _latitude;
  double _longitude;
  Address _address;
  bool _isUpdated = false;
  bool _isKor = false;
  int _x;
  int _y;

  get latitude => _latitude;
  get longitude => _longitude;
  get address => _address.subLocality == null
      ? _address.featureName
      : _address.subLocality;
  get isUpdated => _isUpdated;
  get isKor => _isKor;
  get x => _x;
  get y => _y;

  Future<LocationInfo> getLocation() async {
    LocationData locationData = await locationHelper.getLocation();

    if (locationData == null) return null;

    List<Address> addressList = await locationHelper.getAddress(
        locationData.latitude, locationData.longitude);
    LocationXY locationXY =
        changeGridLocation(locationData.longitude, locationData.latitude);

    _latitude = locationData.latitude;
    _longitude = locationData.longitude;
    _address = addressList[0];
    _x = locationXY.x;
    _y = locationXY.y;

    _isUpdated = true;

    if ((locationXY.x >= 53 && locationXY.x <= 99) &&
        (locationXY.y >= 69 && locationXY.x <= 99)) {
      _isKor = true;
    }

    notifyListeners();

    return this;
  }
}
