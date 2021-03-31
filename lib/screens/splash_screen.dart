import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:provider/provider.dart';
import '../providers/weather.dart';
import '../providers/location_info.dart';
import './weather_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    initLocation();
    
  }

  void initLocation() async {
    LocationInfo locationInfo = await Provider.of<LocationInfo>(context, listen: false).getLocation();
    await Provider.of<Weather>(context, listen: false).getWeather(locationInfo.latitude, locationInfo.longitude);

    Navigator.pushReplacementNamed(context, WeatherScreen.routeName);
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
            Image.asset('assets/images/043-warm.png', height: ScreenUtil().setHeight(150)),
          ]
        ),
      )
    );
  }
}