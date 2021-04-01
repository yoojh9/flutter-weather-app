import 'package:flutter/material.dart';
import 'package:weather_app/models/daily_weather.dart';
import '../models/current_weather.dart';
import '../models/hourly_weather.dart';
import '../network/weather_api.dart' as WeatherAPI;

class Weather with ChangeNotifier{
  double _latitude;
  double _longitude;
  CurrentWeather currentWeather;
  HourlyWeatherList hourlyWeatherList;
  DailyWeatherList dailyWeatherList;

  void setWeatherLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;

    getWeather(_latitude, _longitude);
  }
  
  Future<void> getWeather(double latitude, double longitude) async{
    if(latitude == null || longitude == null) return;

    var body = await WeatherAPI.getWeather(latitude, longitude);

    setCurrentWeather(body);
    setHourlyWeather(body);
    setDailyWeather(body);

    notifyListeners();
  }

  void setCurrentWeather(body) {
    currentWeather = CurrentWeather();
    
    final current = body['current'];
    final daily = body['daily'];
    
    currentWeather.description = current['weather'][0]['description'];
    currentWeather.icon = current['weather'][0]['icon'];
    currentWeather.temp =  current['temp'].toInt();
    currentWeather.tempMin = daily[0]['temp']['min'].toInt();
    currentWeather.tempMax = daily[0]['temp']['max'].toInt();
  }

  void setHourlyWeather(body){
    List hourly = body['hourly'];
    hourlyWeatherList = HourlyWeatherList();

    hourly.forEach((item) {
      HourlyWeather hourlyWeather = HourlyWeather();
      hourlyWeather.dt = item['dt'];
      hourlyWeather.icon = item['weather'][0]['icon'];
      hourlyWeather.temp = item['temp'].toInt();
      hourlyWeatherList.addHourlyWeather(hourlyWeather);
    });
  }

  void setDailyWeather(body){
    List daily = body['daily'];
    dailyWeatherList = DailyWeatherList();

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

