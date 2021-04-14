import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

  Future<dynamic> getOpenWeatherAPI(double lat, double lon) async {
    final API_KEY = env['OPENWEATHER_API_KEY'];
    final urlStr = 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&exclude=minutely&appid=$API_KEY&lang=kr';
    final url = Uri.parse(urlStr);

    try {
      final response = await http.get(url);
      if(response.statusCode != 200 ) {
        throw 'WHEATHER API STATUS CODE NOT 200';
      }
      final body = json.decode(response.body);
      if(body != null){
        return body;
      } else {
        throw 'CURRENT WEATHER API REQUEST FAILED';
      }

    } catch(error){
      throw error;
    }
  }
