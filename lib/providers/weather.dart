import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/daily_weather.dart';
import '../providers/location_info.dart';
import '../models/current_weather.dart';
import '../models/hourly_weather.dart';
import '../network/open_weather_api.dart' as openWeatherAPI;
import '../network/kor_weather_api.dart' as korWeatherAPI;

class Weather with ChangeNotifier{
  LocationInfo _locationInfo;
  CurrentWeather currentWeather;
  HourlyWeatherList hourlyWeatherList;
  DailyWeatherList dailyWeatherList;
  bool _isRequested = false;

  void setWeatherLocation(LocationInfo locationInfo) {
    _locationInfo = locationInfo;
    //getWeather(_locationInfo);
  }
  
  Future<void> getWeather(LocationInfo locationInfo) async{
    if(locationInfo.latitude == null || locationInfo.longitude == null) return;

    currentWeather = CurrentWeather();
    hourlyWeatherList = HourlyWeatherList();
    dailyWeatherList = DailyWeatherList();

    if(!_isRequested){
      _isRequested = true;
      if(locationInfo.isKor) {
        List currentList = await korWeatherAPI.getKorCurrentWeather(locationInfo.x, locationInfo.y);
        List minMaxTempList = await korWeatherAPI.getKorMaxMinTemp(locationInfo.x, locationInfo.y);
        final forecast =  await openWeatherAPI.getOpenWeatherAPI(locationInfo.latitude, locationInfo.longitude);

        setWeatherDataFromKorWether(locationInfo, currentList, minMaxTempList, forecast);
      } else {
        var body = await openWeatherAPI.getOpenWeatherAPI(locationInfo.latitude, locationInfo.longitude);
        setWeatherDataFromOpenWeatherMap(body);
      }
      notifyListeners();    
    }
    _isRequested = false;

  }
  
  // 한국일 경우, 현재날씨는 기상청 데이터에서 가져오도록 변경.
  // 나머지 시간별 날씨, 주간 날씨는 일단 openWeatherMapAPI를 쓰는걸로..
  void setWeatherDataFromKorWether(locationInfo, current, minMaxTemp, forecast){
    setCurrenWeatherCodeWithKorWeather(current);
    setMinMaxTempWithKorWeather(minMaxTemp);
    setHourlyOpenWeather(forecast);
    setDailyOpenWeather(forecast);
  }

  void setWeatherDataFromOpenWeatherMap(body){
    setCurrentOpenWeather(body);
    setHourlyOpenWeather(body);
    setDailyOpenWeather(body);
  }

  void setCurrenWeatherCodeWithKorWeather(List currentItemList){
    final tempItem = currentItemList.firstWhere((item) => item['category']=="T1H");
    currentWeather.temp = int.parse(tempItem['fcstValue']);

    final skyItem = currentItemList.firstWhere((item) => item['category']=="SKY");
    final ptyItem = currentItemList.firstWhere((item) => item['category']=="PTY");

    DateTime dateTime = DateTime.now().toUtc().add(Duration(hours: 9));
    int hour = int.parse(DateFormat.H().format(dateTime));

    switch (skyItem['fcstValue']) {
      case "1": currentWeather.id=800; currentWeather.icon="01";  break;
      case "3": currentWeather.id=803; currentWeather.icon="03"; break;
      case "4": currentWeather.id=804; currentWeather.icon="04"; break;
      default : currentWeather.id=800; currentWeather.icon="01"; break;
    }

    switch(ptyItem['fcstValue']){
      case "0": break;
      case "1": currentWeather.id=501; currentWeather.icon="09"; break;
      case "2": case "6": currentWeather.id=611; currentWeather.icon="13"; break;
      case "3": case "7": currentWeather.id=601; currentWeather.icon="13"; break;
      case "4": currentWeather.id=505; currentWeather.icon="09"; break;
      case "5": currentWeather.id=500; currentWeather.icon="10"; break;
      default: break;
    }

    if(hour >= 7 && hour < 19) currentWeather.icon+="d";
    else currentWeather.icon+="n";
  }

  void setMinMaxTempWithKorWeather(List minMaxTempList){

    if(minMaxTempList == null) {
      currentWeather.tempMax = null;
      currentWeather.tempMin = null;
      return;
    }

    final minItem = minMaxTempList.firstWhere((item) => item['category']=="TMN");
    final maxItem = minMaxTempList.firstWhere((item) => item['category']=="TMX");

    currentWeather.tempMin = double.parse(minItem['fcstValue']).toInt();
    currentWeather.tempMax = double.parse(maxItem['fcstValue']).toInt();

  }

  void setCurrentOpenWeather(body) {
    
    final current = body['current'];
    final daily = body['daily'];
    
    currentWeather.id = current['weather'][0]['id'];
    //currentWeather.description = current['weather'][0]['description'];
    currentWeather.icon = current['weather'][0]['icon'];

    currentWeather.temp =  current['temp'].toInt();
    currentWeather.tempMin = daily[0]['temp']['min'].toInt();
    currentWeather.tempMax = daily[0]['temp']['max'].toInt();
  }

  void setHourlyOpenWeather(body){
    List hourly = body['hourly'];

    hourly.forEach((item) {
      HourlyWeather hourlyWeather = HourlyWeather();
      hourlyWeather.dt = item['dt'];
      hourlyWeather.icon = item['weather'][0]['icon'];
      hourlyWeather.temp = item['temp'].toInt();
      hourlyWeatherList.addHourlyWeather(hourlyWeather);
    });
  }

  void setDailyOpenWeather(body){
    List daily = body['daily'];

    daily.forEach((item) {
      DailyWeather dailyWeather = DailyWeather();
      dailyWeather.dt = item['dt'];
      dailyWeather.icon = item['weather'][0]['icon'];
      dailyWeather.tempMin = item['temp']['min'].toInt();
      dailyWeather.tempMax = item['temp']['max'].toInt();
      dailyWeatherList.addDailyWeather(dailyWeather);
    });

  }

}

