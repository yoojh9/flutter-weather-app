import 'package:flutter/material.dart';
import '../providers/location_info.dart';
import '../models/current_weather.dart';
import '../models/hourly_weather.dart';
import '../models/weekly_weather.dart';
import '../network/open_weather_api.dart' as openWeatherAPI;
import '../network/kor_weather_api.dart' as korWeatherAPI;

class Weather with ChangeNotifier{
  LocationInfo _locationInfo;
  CurrentWeather currentWeather;
  HourlyWeatherList hourlyWeatherList;
  WeeklyWeatherList weeklyWeatherList;
  bool _isRequested = false;

  void setLocation(LocationInfo locationInfo) {
    _locationInfo = locationInfo;
    //getWeather(_locationInfo);
  }
  
  Future<void> getWeather() async{
    if(_locationInfo.latitude == null || _locationInfo.longitude == null) return;

    currentWeather = CurrentWeather();
    hourlyWeatherList = HourlyWeatherList();
    weeklyWeatherList = WeeklyWeatherList();

    if(!_isRequested){
      _isRequested = true;
      
      if(_locationInfo.isKor) {
        await setWeatherDataFromKorWeather(_locationInfo);
      } else {
        await setWeatherDataFromOpenWeatherMap(_locationInfo);
      }
      notifyListeners();    
    }

    _isRequested = false;

  }
  
  // 한국일 경우, 현재날씨는 기상청 데이터에서 가져오도록 변경.
  // 나머지 시간별 날씨, 주간 날씨는 일단 openWeatherMapAPI를 쓰는걸로..
  Future<void> setWeatherDataFromKorWeather(locationInfo) async {
    List currentList = await korWeatherAPI.getKorCurrentWeather(locationInfo.x, locationInfo.y);
    List minMaxTempList = await korWeatherAPI.getKorMaxMinTemp(locationInfo.x, locationInfo.y);
    final forecast =  await openWeatherAPI.getOpenWeatherAPI(locationInfo.latitude, locationInfo.longitude);

    setCurrenWeatherCodeWithKorWeather(currentList, forecast);
    setMinMaxTempWithKorWeather(minMaxTempList);
    setHourlyOpenWeather(forecast);
    setDailyOpenWeather(forecast);

  }

  // 외국일 경우 openWeatherAPI 이용
  Future<void> setWeatherDataFromOpenWeatherMap(locationInfo) async {
    var body = await openWeatherAPI.getOpenWeatherAPI(locationInfo.latitude, locationInfo.longitude);

    setCurrentOpenWeather(body);
    setHourlyOpenWeather(body);
    setDailyOpenWeather(body);
  }

  /*
   * 기상청 동네예보 API 사용
   */
  void setCurrenWeatherCodeWithKorWeather(List currentItemList, final forecast){
    final openWeathrApiBody = forecast['current'];
    currentWeather.sunrise = openWeathrApiBody["sunrise"];
    currentWeather.sunset = openWeathrApiBody['sunset'];
    
    final tempItem = currentItemList.firstWhere((item) => item['category']=="T1H");
    currentWeather.temp = int.parse(tempItem['fcstValue']);

    final skyItem = currentItemList.firstWhere((item) => item['category']=="SKY");
    final ptyItem = currentItemList.firstWhere((item) => item['category']=="PTY");

    DateTime dateTime = DateTime.now().toLocal();

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

    // 일몰 일출 시간에 따라 아이콘 변경
    if(dateTime.isAfter(currentWeather.sunriseDateTime) && dateTime.isBefore(currentWeather.sunsetDateTime)){
      currentWeather.icon+="d";
    } else {
      currentWeather.icon+="n";
    }
  }

  /*
   * OpenWeatherMap API 사용
   */
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

    currentWeather.sunrise = current['current']["sunrise"];
    currentWeather.sunset = current['current']['sunset'];

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
      WeeklyWeather weeklyWeather = WeeklyWeather();
      weeklyWeather.dt = item['dt'];
      weeklyWeather.icon = item['weather'][0]['icon'];
      weeklyWeather.tempMin = item['temp']['min'].toInt();
      weeklyWeather.tempMax = item['temp']['max'].toInt();
      weeklyWeatherList.addDailyWeather(weeklyWeather);
    });
  }

}

