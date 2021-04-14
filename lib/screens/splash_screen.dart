import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screens/error_screen.dart';
import '../widgets/splash_widget.dart';
import '../providers/weather.dart';
import '../providers/location_info.dart';
import './weather_screen.dart';

class SplashScreen extends StatefulWidget {

  static final routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  // AnimationController _controller;
  // Animation _animation;

  @override
  void initState() {
    initLocation();

    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 800),
    // )..repeat(reverse: true);

    // _animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeIn,
    // );

    super.initState();  
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  void initLocation() async {
    try {
      LocationInfo locationInfo = await Provider.of<LocationInfo>(context, listen: false).getLocation();
      
      await Provider.of<Weather>(context, listen: false).getWeather(locationInfo);
      
      Navigator.pushReplacementNamed(context, WeatherScreen.routeName);
    } catch(error){
      print(error);
      Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWidget()
    );
  }
}