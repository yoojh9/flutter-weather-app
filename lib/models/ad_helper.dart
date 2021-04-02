import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    // Test용임. 나중에 변경해야함.
    if(Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if(Platform.isAndroid) {
      return  'ca-app-pub-3940256099942544/6300978111';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}