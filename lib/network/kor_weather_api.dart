import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';


Future<dynamic> getKorCurrentWeather(int x, int y) async {
    final apiKey = env['KOR_WEATHER_API_KEY'];
    DateTime dateTime = DateTime.now().toUtc().add(Duration(hours: 9)).subtract(Duration(minutes: 45));
    final baseDate = DateFormat('yyyyMMdd').format(dateTime);
    final baseTime = DateFormat.H().format(dateTime)+"30";

    final urlStr = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getUltraSrtFcst?serviceKey=$apiKey&pageNo=1&numOfRows=100&dataType=JSON&base_date=$baseDate&base_time=$baseTime&nx=$x&ny=$y';
    final url = Uri.parse(urlStr);

    try {
      final response = await http.get(url);
      if(response.statusCode != 200 ) {
        throw 'WHEATHER KOR API STATUS CODE NOT 200';
      }
      final body = json.decode(response.body);

      if(body != null){
        if(body['response']['header']['resultCode'] != "00") throw ('KOR WEATHER API ERROR');
        return body['response']['body']['items']['item'];

      } else {
        throw '기상청 초단기예보조회 API 오류';
      }

    } catch(error){
      print(error);
      throw error;
    }
}


/*
 * 02:00 예보 호출로 최저기온 최고기온 얻어옴
 */
Future<dynamic> getKorMaxMinTemp(int x, int y) async {
    final apiKey = env['KOR_WEATHER_API_KEY'];

    DateTime dateTime = DateTime.now().toUtc().add(Duration(hours: 9)).subtract(Duration(minutes: 10));
    String baseDate = DateFormat('yyyyMMdd').format(dateTime);
    int baseTime = int.parse(DateFormat.H().format(dateTime));

    if(baseTime < 2){
      baseDate = DateFormat('yyyyMMdd').format(dateTime.subtract(Duration(days: 1)));
    }

    final urlStr = 'http://apis.data.go.kr/1360000/VilageFcstInfoService/getVilageFcst?serviceKey=$apiKey&pageNo=1&numOfRows=100&dataType=JSON&base_date=$baseDate&base_time=0200&nx=$x&ny=$y';
    final url = Uri.parse(urlStr);

    try {
      final response = await http.get(url);
      if(response.statusCode != 200 ) {
        throw 'WHEATHER KOR API STATUS CODE NOT 200';
      }
      final body = json.decode(response.body);

      if(body != null){
        if(body['response']['header']['resultCode'] == "00") {
          return body['response']['body']['items']['item'];
        }
      } 
      return null;

    } catch(error){
      print(error);
      throw error;
    }
  }