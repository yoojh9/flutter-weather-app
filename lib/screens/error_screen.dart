import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import './splash_screen.dart';

class ErrorScreen extends StatelessWidget {
  
  static final routeName = '/error';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(80)),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.error_outline_outlined, size: ScreenUtil().setSp(50), color: Colors.black45,),      
            Column(
              children: [
                Text('일시적인 오류가 발생했습니다', style: TextStyle(
                    fontSize: ScreenUtil().setSp(24),
                    fontWeight: FontWeight.w900,
                    color: Colors.black87
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text('새로고침을 눌러 \n 페이지를 다시 불러올 수 있습니다.' , style: TextStyle(
                  fontSize: ScreenUtil().setSp(18),
                  color: Colors.black54,
                  ),
                 textAlign: TextAlign.center, 
                )
              ]
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
              }, 
              child: Container(
                padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(5)),
                child: Text('새로고침', style: Theme.of(context).textTheme.bodyText1)
              ),
            )
          ]
        ),
      )
    );
  }
}