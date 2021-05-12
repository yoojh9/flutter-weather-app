import 'package:flutter/material.dart';
import './location_info.dart';
import '../network/kakao_api.dart' as KakaoAPI;
import '../network/airkorea_api.dart' as AirKoreaAPI;

class Dust with ChangeNotifier {
  LocationInfo _locationInfo;
  String pm10Grade;
  String pm25Grade;

  get pm10GradeTxt {
    switch (pm10Grade) {
      case "1":
        return "좋음";
        break;
      case "2":
        return "보통";
        break;
      case "3":
        return "나쁨";
        break;
      case "4":
        return "매우나쁨";
        break;
      default:
        return "-";
        break;
    }
  }

  get pm25GradeTxt {
    switch (pm25Grade) {
      case "1":
        return "좋음";
        break;
      case "2":
        return "보통";
        break;
      case "3":
        return "나쁨";
        break;
      case "4":
        return "매우나쁨";
        break;
      default:
        return "-";
        break;
    }
  }

  void setLocation(LocationInfo locationInfo) {
    _locationInfo = locationInfo;
    //getWeather(_locationInfo);
  }

  Future<void> getDust() async {
    try {
      if (!_locationInfo.isKor) return; // 위치정보가 한국이 아닐 경우
      final tmXY = await KakaoAPI.getTmXY(
          _locationInfo.latitude, _locationInfo.longitude); // TM 좌표로 변환
      if (tmXY == null) return;
      final station = await AirKoreaAPI.getStationName(tmXY['x'], tmXY['y']);
      if (station == null) return;
      final stationName = station['stationName'];
      final dust = await AirKoreaAPI.getDustData(stationName);
      if (dust == null) return;
      pm10Grade = dust['pm10Grade1h'];
      pm25Grade = dust['pm25Grade1h'];
    } catch(error){
      _locationInfo.isKor = false;
      print('getDust error : $error');
    } finally {
      notifyListeners();
    }

  }
}
