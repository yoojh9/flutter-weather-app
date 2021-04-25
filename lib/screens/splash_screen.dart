import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import './error_screen.dart';
import '../widgets/splash_widget.dart';
import '../providers/weather.dart';
import '../providers/location_info.dart';
import '../providers/dust.dart';
import './weather_screen.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  bool loaded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    if (!loaded) {
      initLocation();
    }

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
      Timer(Duration(seconds: 1), () {
        if (!loaded) {
          initLocation();
        }
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void initLocation() async {
    setState(() {
      loaded = true;
    });

    try {
      LocationInfo locationInfo =
          await Provider.of<LocationInfo>(context, listen: false).getLocation();

      if (locationInfo == null) {
        await showLocationPermissionDialog();
        setState(() {
          loaded = false;
        });
      } else {
        await Provider.of<Weather>(context, listen: false).getWeather();
        if (locationInfo.isKor) {
          await Provider.of<Dust>(context, listen: false).getDust();
        }
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
                content: Text(
                    '투데이날씨 앱을 사용하기 위해서는 위치 권한 허용이 필요합니다. 앱 설정 > 권한에서 위치를 추가해주세요.'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await openAppSettings();
                    },
                    child: Text('확인'),
                  )
                ],
              ));
    }
  }
}
