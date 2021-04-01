import 'package:intl/intl.dart';

class HourlyWeather {
  int _dt;
  int _temp;
  String _icon;

  set dt(int dt) => _dt = dt;

  set temp(int temp) => _temp = temp;

  set icon(String icon) => _icon = icon;

  get hour {
    var datetime = DateTime.fromMillisecondsSinceEpoch(_dt * 1000).toLocal();
    return DateFormat.H().format(datetime);
  }

  get icon => _icon;

  get temp => _temp;

}

class HourlyWeatherList {
  List<HourlyWeather> _hourlyWeatherList = [];

  List<HourlyWeather> get items {
    return [..._hourlyWeatherList];
  }

  void addHourlyWeather(HourlyWeather hourlyWeather) {
    _hourlyWeatherList.add(hourlyWeather);
  }
}