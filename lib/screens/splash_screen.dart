import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    print('initState');
    WidgetsBinding.instance.addObserver(this);
    initLocation();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      print('resume');
      Timer(Duration(seconds: 1), () {
        initLocation();
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void initLocation() async {
    print('initLocation()');
    try {
      LocationInfo locationInfo =
          await Provider.of<LocationInfo>(context, listen: false).getLocation();

      print('locationInfo = $locationInfo');

      if (locationInfo == null) {
        await showLocationPermissionDialog();
      } else {
        await Provider.of<Weather>(context, listen: false)
            .getWeather(locationInfo);
        await Navigator.pushReplacementNamed(context, WeatherScreen.routeName);
      }
    } catch (error) {
      print(error);
      Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashWidget());
  }

  Future<bool> showLocationPermissionDialog() {
    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text('위치 정보 권한 설정'),
                content: Text('투데이날씨 앱을 사용하기 위해서는 위치 권한 허용이 필요합니다'),
                actions: [
                  CupertinoDialogAction(
                      child: Text("확인"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await openAppSettings();
                      })
                ],
              ));
    } else {
      return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('위치 정보 권한 설정'),
                content: Text('투데이날씨 앱을 사용하기 위해서는 위치 권한 허용이 필요합니다'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Permission.contacts.shouldShowRequestRationale;
                    },
                    child: Text('확인'),
                  )
                ],
              ));
    }
  }
}
