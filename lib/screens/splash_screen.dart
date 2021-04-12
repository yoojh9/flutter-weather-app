import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/error_screen.dart';
import 'package:weather_app/utils/weather_xy.dart';
import '../providers/weather.dart';
import '../providers/location_info.dart';
import './weather_screen.dart';

class SplashScreen extends StatefulWidget {

  static final routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    initLocation();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    super.initState();  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initLocation() async {
    print('initLocation()');

    try {
      LocationInfo locationInfo = await Provider.of<LocationInfo>(context, listen: false).getLocation();
      Weather_xy weatherXY = changelaluMap(locationInfo.longitude, locationInfo.latitude);

      locationInfo.x = weatherXY.x;
      locationInfo.y = weatherXY.y;

      print('x='+locationInfo.x.toString() + "y=" +locationInfo.y.toString());
      await Provider.of<Weather>(context, listen: false).getWeather(locationInfo.latitude, locationInfo.longitude);
        
      

      Navigator.pushReplacementNamed(context, WeatherScreen.routeName);
    } catch(error){
      print(error);
      Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/048-umbrella.png', height: ScreenUtil().setHeight(150)),
            SizedBox(height: ScreenUtil().setHeight(10)),
            FadeTransition(
              opacity: _animation,
              child: Text('Loading...', style: TextStyle(
                fontSize: ScreenUtil().setSp(20),
                fontWeight: FontWeight.w600,
                color: Colors.black54
              ),
              textAlign: TextAlign.center,
             )
            )
          ]
        ),
      )
    );
  }
}