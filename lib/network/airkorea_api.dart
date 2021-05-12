import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
 * 측정소 정보 조회
 */
Future<dynamic> getStationName(double tmX, double tmY) async {
  final apiKey = env['KOR_WEATHER_API_KEY'];
  final urlStr =
      'http://apis.data.go.kr/B552584/MsrstnInfoInqireSvc/getNearbyMsrstnList?serviceKey=$apiKey&returnType=json&tmX=$tmX&tmY=$tmY';
  final url = Uri.parse(urlStr);

  try {
    final response = await http.get(url);
    print('response : ${response.body}');
    if (response.body == null || response.body.isEmpty) {
      return null;
    }

    if (response.statusCode != 200) {
      throw 'AIRKOREA API STATUS CODE NOT 200';
    }
    final body = json.decode(response.body);
    print('body = $body');
    if (body != null || body != "") {
      return body['response']['body']['items'][0];
    } else {
      throw '에어코리아 측정소 정보 조회 API 오류';
    }
  } catch (error) {
    throw error;
  }
}

/*
 * 측정소별 실시간 미세먼지 정보 조회
 */
Future<dynamic> getDustData(String stationName) async {
  final apiKey = env['KOR_WEATHER_API_KEY'];
  final urlStr =
      'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?serviceKey=$apiKey&returnType=json&numOfRows=5&pageNo=1&stationName=$stationName&dataTerm=DAILY&ver=1.3';
  final url = Uri.parse(urlStr);

  try {
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw 'AIRKOREA DUST API STATUS CODE NOT 200';
    }
    if (response.body == null || response.body.isEmpty) {
      return null;
    }
    final body = json.decode(response.body);

    if (body != null) {
      return body['response']['body']['items'][0];
    } else {
      throw '에어코리아 미세먼지 조회 API 오류';
    }
  } catch (error) {
    print(error);
    throw error;
  }
}
