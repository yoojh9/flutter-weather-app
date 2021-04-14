import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import '../screens/weather_screen.dart';

class VersionScreen extends StatefulWidget {
  
  static final routeName = '/version';

  @override
  _VersionScreenState createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  String _version;
  String _newVersion;
  bool _isLatest = true;

  @override
  void initState() {
    super.initState();

    _getPackageInfo();
    _checkNewVersion();
  }


  void _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(packageInfo.version!=null){
      setState(() {
        _version = packageInfo.version;
      });
    }
  }

  void _checkNewVersion() async {
    final RemoteConfig remoteConfig = RemoteConfig.instance;
    String newVersion = "";

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(hours: 1),
    ));

    if(Platform.isIOS){
      await remoteConfig.setDefaults(<String, dynamic>{
        "ios_latest_version": '1.0.0',
      });
      await remoteConfig.fetchAndActivate();
      newVersion = remoteConfig.getString('ios_latest_version');
    } else if(Platform.isAndroid){
      await remoteConfig.setDefaults(<String, dynamic>{
        "android_latest_version": '1.0.0',
      });
      await remoteConfig.fetchAndActivate();
      newVersion = remoteConfig.getString('android_latest_version');
    } else {
      await remoteConfig.setDefaults(<String, dynamic>{
        "latest_version": '1.0.0',
      });
      await remoteConfig.fetchAndActivate();
      newVersion = remoteConfig.getString('latest_version');
    }
    
    setState(() {
      _newVersion = newVersion;
      _isLatest = int.parse(_version.replaceAll(".", "")) >= int.parse(_newVersion.replaceAll(".", ""));
    });
  }
  

  void _back(){
    Navigator.of(context).pushReplacementNamed(WeatherScreen.routeName);
  }

  void _showVersionUpdateDialog(ctx) async {
    await showDialog(
      context: ctx, 
      builder: (BuildContext ctx2){
        String title = "투데이날씨 버전 업그레이드";
        String message = "지금 바로 업데이트 하시겠습니까?";

        return Platform.isIOS
        ? CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('업데이트 하기'),
              onPressed: _launchAppStore,
            ),
            TextButton(child: Text('나중에'), onPressed: () => Navigator.pop(ctx2), )
          ],
        )
        : AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('업데이트 하기'),
              onPressed: _launchAppStore,
            ),
            TextButton(child: Text('나중에'), onPressed: () => Navigator.pop(ctx2), )
          ],
        );
      }
    );
  }

  void _launchAppStore(){
    LaunchReview.launch(androidAppId: "kr.jeonghyun.today_weather", iOSAppId: "1561301672");
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("버전정보", style: Theme.of(context).textTheme.headline6.copyWith(color :Colors.black87),),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back, color: Colors.black87,),
            onTap: _back,
          ), 
        ),
        child: _contentBody(context),
      )
      : Scaffold(
        appBar: AppBar(
          title: Text("버전정보", style: Theme.of(context).textTheme.headline6.copyWith(color :Colors.black87),),
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.black87, onPressed: _back,),    
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
              ..._versionContent(ctx)
            ],
          )
        ],
      )
    );
  }

  List<Widget> _versionContent(BuildContext ctx){
    if(_isLatest) {
      return [
        SizedBox(height: ScreenUtil().setHeight(15),),
        Text('최신버전입니다', style: Theme.of(ctx).textTheme.bodyText2.copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
        SizedBox(height: ScreenUtil().setHeight(10),),
        Text('현재버전: v$_version', style: Theme.of(ctx).textTheme.bodyText2.copyWith(color: Colors.black87))
      ];
    } else {
      return [
        SizedBox(height: ScreenUtil().setHeight(15),),
        Text('최신버전: ${_newVersion == null ? "-" : _newVersion}', style: Theme.of(ctx).textTheme.bodyText2.copyWith(color: Colors.black87, fontWeight: FontWeight.bold)),
        SizedBox(height: ScreenUtil().setHeight(10),),
        Text('현재버전: v$_version', style: Theme.of(ctx).textTheme.bodyText2.copyWith(color: Colors.black87)),
        SizedBox(height: ScreenUtil().setHeight(20),),
        TextButton(
          onPressed: (){
            _showVersionUpdateDialog(ctx);
          },
          child: Text('업데이트 하기', style: TextStyle(fontSize: ScreenUtil().setHeight(16)),),
        )
      ];
    }
  }
}