import 'package:intl/intl.dart';

class WeeklyWeather {
  int _dt;
  int _tempMin;
  int _tempMax;
  String _icon;

  set dt(int dt) => _dt = dt;

  set tempMin(int tempMin) => _tempMin = tempMin;

  set tempMax(int tempMax) => _tempMax = tempMax;

  set icon(String icon) => _icon = icon;

  get day {
    var datetime = DateTime.fromMillisecondsSinceEpoch(_dt * 1000).toLocal();
    return DateFormat.E().format(datetime);
  }

  get icon => _icon;

  get tempMin => _tempMin;

  get tempMax => _tempMax;

}

class WeeklyWeatherList {
  List<WeeklyWeather> _weeklyWeatherList = [];

  List<WeeklyWeather> get items {
    return [..._weeklyWeatherList];
  }

  void addDailyWeather(WeeklyWeather weeklyWeather) {
    _weeklyWeatherList.add(weeklyWeather);
  }
}