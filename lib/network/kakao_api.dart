import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
 * 위도 경도 -> TmY TmX 좌표로 변경하는 API 호출
 */
Future<dynamic> getTmXY(double latitude, double longitude) async {
    final headers = {
      'Authorization': env['KAKAO_AUTHKEY']
    };

    final urlStr = 'https://dapi.kakao.com/v2/local/geo/transcoord.json?x=$longitude&y=$latitude&input_coord=WGS84&output_coord=TM';
    final url = Uri.parse(urlStr);

    try {
      final response = await http.get(url, headers: headers);
      if(response.statusCode != 200 ) {
        throw 'KAKAO API STATUS CODE NOT 200';
      }
      final body = json.decode(response.body);

      if(body != null){
        return body['documents'][0];
      } else {
        throw '카카오 좌표계 API 오류';
      }

    } catch(error){
      print(error);
      throw error;
    }
}