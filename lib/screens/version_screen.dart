import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:package_info/package_info.dart';
import '../screens/weather_screen.dart';

class VersionScreen extends StatefulWidget {
  
  static final routeName = '/version';

  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  var _version;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPackageInfo();
  }

  void _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      _version = packageInfo.version;
    });
  }

  void _back(){
    Navigator.of(context).pushReplacementNamed(WeatherScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('버전정보'),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back,),
            onTap: _back,
          ), 
        ),
        child: _contentBody(context),
      )
      : Scaffold(
        appBar: AppBar(
          title: Text("버전정보"),
          leading: IconButton(icon: Icon(Icons.arrow_back) , onPressed: _back,),    
          backgroundColor: Colors.transparent,
        ),
        body: _contentBody(context),
      );
  }

  Widget _contentBody(BuildContext ctx){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/048-umbrella.png', height: ScreenUtil().setHeight(120),),
          Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(10),),
              Text('최신버전입니다', style: Theme.of(ctx).textTheme.headline6.copyWith(color: Colors.black87)),
              SizedBox(height: ScreenUtil().setHeight(10),),
              Text('현재버전: $_version', style: Theme.of(ctx).textTheme.bodyText2.copyWith(color: Colors.black87))
            ],
          )
        ],
      )
    );
  }
}