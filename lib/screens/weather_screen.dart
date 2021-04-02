
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/location_info.dart';
import '../providers/weather.dart';
import '../theme/color.dart';
import '../widgets/daily_weather_list.dart';
import '../widgets/hourly_weather_list.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/ads_banner_page.dart';



class WeatherScreen extends StatefulWidget {
  
  static final routeName = '/weather';

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}


class _WeatherScreenState extends State<WeatherScreen> {
  
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

  }

  void _refresh() async{
    LocationInfo locationInfo = await Provider.of<LocationInfo>(context, listen: false).getLocation();
    await Provider.of<Weather>(context, listen: false).getWeather(locationInfo.latitude, locationInfo.longitude);
  }

  void _toggle() {
    print('toggle');
    _innerDrawerKey.currentState.toggle(
      direction: InnerDrawerDirection.start
    );
  }

  @override
  Widget build(BuildContext context) {
    final weather = Provider.of<Weather>(context, listen: true);
    final location = Provider.of<LocationInfo>(context, listen: true);

    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      swipe: true,
      //scale: IDOffset.horizontal(0.9),
      //borderRadius: 30,
      leftAnimationType: InnerDrawerAnimation.linear,
      backgroundDecoration: BoxDecoration(color: Colors.white),
      offset: IDOffset.only(bottom: 0.0, right: 0.0, left: 0.6),
      leftChild: DrawerMenu(),
    
      scaffold: Platform.isIOS 
        ? CupertinoPageScaffold(
          child: _weatherBody(context, location, weather)
        )
        : Scaffold(
          body: _weatherBody(context, location, weather),
        )
    );
  }

  Widget _weatherBody(BuildContext ctx, final location, final weather){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(12)
      ),
      color: CustomColor.getWeatherColor(weather.currentWeather.icon),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor:  CustomColor.getWeatherColor(weather.currentWeather.icon) ,
            pinned: true,
            //floating: true,
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.menu), onPressed: _toggle,),
            actions: [
              IconButton(icon: Icon(Icons.refresh), onPressed: _refresh,)
            ],
            //expandedHeight: ScreenUtil().setHeight(100),
            flexibleSpace: Container(
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
              alignment: Alignment.bottomCenter,
              child: Text('${location.isUpdated ? location.address : ''}', style: Theme.of(ctx).textTheme.headline4, textAlign: TextAlign.center,),
              // ListView(
              //   children: [
              //     Text('${location.isUpdated ? location.address : ''}', style: Theme.of(ctx).textTheme.headline4, textAlign: TextAlign.center,),
              //   ]
              // ),
            ),
          ),

          CurrentWeatherWidget(weather.currentWeather),
          
          HourlyWeatherList(weather.hourlyWeatherList.items),
          AdsBannerPage(),
          //SizedBox(height: ScreenUtil().setHeight(20)),
          DailyWeatherList(weather.dailyWeatherList.items),
        ],
      ),
    );
  }
}