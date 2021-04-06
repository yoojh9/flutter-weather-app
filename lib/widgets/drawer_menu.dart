import 'package:flutter/material.dart';
import './drawer_header_section.dart';
import '../screens/version_screen.dart';
import '../models/license.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DrawerMenu extends StatelessWidget {
  final _url = 'https://firebasestorage.googleapis.com/v0/b/jeonghyun-today-weather.appspot.com/o/%E1%84%8B%E1%85%B1%E1%84%8E%E1%85%B5%E1%84%80%E1%85%B5%E1%84%87%E1%85%A1%E1%86%AB%E1%84%89%E1%85%A5%E1%84%87%E1%85%B5%E1%84%89%E1%85%B3%E1%84%8B%E1%85%B5%E1%84%8B%E1%85%AD%E1%86%BC%E1%84%8B%E1%85%A3%E1%86%A8%E1%84%80%E1%85%AA%E1%86%AB.html?alt=media&token=221d5964-2a45-49b5-8e0e-88e1b5c5a51b';
  void _launchUrl() async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(300),
            child: DrawerHeaderSection(),),
          Expanded(
            child: ListView(
              itemExtent: ScreenUtil().setHeight(50),
              children: [
                ListTile(
                  title: Text('버전정보', 
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87
                    ),
                  ),
                  onTap: (){
                    Navigator.of(context).pushNamed(VersionScreen.routeName);
                  },
                ),
                ListTile(
                  title: Text('위치기반이용약관', 
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87
                    )
                  ),
                  onTap: _launchUrl,
                ),
                ListTile(
                  title: Text('오픈소스라이센스',
                   style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black87
                    )
                  ),
                  onTap: (){
                    License.showLicensePage(context: context);
                  },
                )
            ],)
          )

        ],
      )
    );
  }
}