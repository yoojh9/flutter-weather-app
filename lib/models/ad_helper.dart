import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdHelper {
  static String get bannerAdUnitId {
    // Test용임. 나중에 변경해야함.
    if(Platform.isIOS) {
      //return 'ca-app-pub-3940256099942544/2934735716';
      return env['GOOGLE_ADMOB_BANNER_ID_IOS'];
    } else if(Platform.isAndroid) {
      //return  'ca-app-pub-3940256099942544/6300978111';
      return env['GOOGLE_ADMOB_BANNER_ID_ANDROID'];
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}