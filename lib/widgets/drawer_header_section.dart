import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

class DrawerHeaderSection extends StatefulWidget {
  @override
  _DrawerHeaderSectionState createState() => _DrawerHeaderSectionState();
}

class _DrawerHeaderSectionState extends State<DrawerHeaderSection> {
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

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
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
            Text('v$_version', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black54))
          ],)
      ),
    );
  }
}