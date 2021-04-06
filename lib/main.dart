import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import './models/license.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import './screens/error_screen.dart';
import './screens/version_screen.dart';
import './screens/weather_screen.dart';
import './screens/splash_screen.dart';
import './providers/weather.dart';
import './providers/location_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

void main() async{
  await DotEnv.load();
  await Firebase.initializeApp();

  MobileAds.instance.initialize();
  License.load();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocationInfo(),),
      ChangeNotifierProxyProvider<LocationInfo, Weather>(
        create: (_) => Weather(),
        update: (_, locationInfo, currentWeather) => currentWeather..setWeatherLocation(locationInfo.latitude, locationInfo.longitude) )
      //ChangeNotifierProvider(create: (_) => CurrentWeather()),
    ],
    child: MyApp()),
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);

    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: false,
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '투데이날씨',
          theme: ThemeData(
            //primarySwatch: CustomColor.blue,
            accentColor: Color(0xFFf5a44d),
            fontFamily: 'NotoSansKR',
            textTheme: ThemeData.light().textTheme.copyWith(
              headline1: TextStyle(
                fontSize: ScreenUtil().setSp(70),
                fontWeight: FontWeight.w300,
                color: Colors.white               
              ),
              headline4: TextStyle(
                fontSize: ScreenUtil().setSp(28),
                fontWeight: FontWeight.w800,
                color: Colors.white
              ),
              headline6: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                color: Colors.white
              ),
              bodyText1: TextStyle(
                fontSize: ScreenUtil().setSp(14),
                color: Colors.white
              ),
              bodyText2: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(18),
              ),

              button: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(14)
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(20))
                ),
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(8), 
                  horizontal: ScreenUtil().setWidth(4))
              )
            ),
            appBarTheme: AppBarTheme(
              elevation: 0,
              
              textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                )
              ),
              iconTheme: IconThemeData(
                size: ScreenUtil().setWidth(10),
                color: Colors.white
              ),
              actionsIconTheme: IconThemeData(
                size: ScreenUtil().setWidth(10),
                color: Colors.white
              )
            )
          ),
          
          home: SplashScreen(),
          routes: {
            WeatherScreen.routeName: (ctx) => WeatherScreen(),
            VersionScreen.routeName: (ctx) => VersionScreen(),
            ErrorScreen.routeName: (ctx) => ErrorScreen(),
          }
      )
    );
  }
}