import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../models/hourly_weather.dart';
import './item/hourly_weather_item.dart';

class HourlyWeatherList extends StatelessWidget {
  List<HourlyWeather> hourlyWeatherList;

  HourlyWeatherList(this.hourlyWeatherList);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: ScreenUtil().setHeight(100),
        margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(25),), 
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, i) => HourlyWeatherItem(i, hourlyWeatherList[i].hour, hourlyWeatherList[i].icon, hourlyWeatherList[i].temp),
          itemCount: hourlyWeatherList.length,
        )
        
        // ListView(
        //   scrollDirection: Axis.horizontal,
        //   children: [
        //     HourlyWeatherItem(0, '지금', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(1, '12', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(2, '13', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(3, '14', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(4, '15', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(4, '16', 'assets/images/039-sun.png', '14'),
        //     HourlyWeatherItem(4, '17', 'assets/images/039-sun.png', '14'),
        //   ]
        // )
      ),
    );
  }
}