import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/version_screen.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    minRadius: ScreenUtil().setHeight(20),
                    maxRadius: ScreenUtil().setHeight(30),
                    child: ClipOval(
                      child: Image.asset('assets/images/048-umbrella.png')
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text('오늘날씨', style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black87, fontSize: ScreenUtil().setSp(16))),
                  Text('v1.0.1', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black54))
                ],)
            ),
          ),
          ListTile(
            title: Text('버전정보'),
            onTap: (){
              Navigator.of(context).pushNamed(VersionScreen.routeName);
            },
          ),
          ListTile(
            title: Text('위치기반이용약관'),
            onTap: (){},
          ),
          ListTile(
            title: Text('오픈소스라이센스'),
            onTap: (){},
          )
        ],
      )
    );
  }
}