import 'package:intl/intl.dart';

class DailyWeather {
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

class DailyWeatherList {
  List<DailyWeather> _dailyWeatherList = [];

  List<DailyWeather> get items {
    return [..._dailyWeatherList];
  }

  void addDailyWeather(DailyWeather dailyWeather) {
    _dailyWeatherList.add(dailyWeather);
  }
}