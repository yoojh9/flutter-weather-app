import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../models/current_weather.dart';
import '../models/weekly_weather.dart';

class WeeklyWeatherList extends StatelessWidget {
  final CurrentWeather currentWeather;
  final List<WeeklyWeather> weeklyWeatherList;

  WeeklyWeatherList(this.currentWeather, this.weeklyWeatherList);


  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(50),
            child: Row(
              children: [
                Expanded(
                  flex:1,
                  child: Text('${weeklyWeatherList[index].day}', style: Theme.of(context).textTheme.bodyText2,)
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/weather/${weeklyWeatherList[index].icon}.png',  height: ScreenUtil().setHeight(30),)
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${index==0 ? currentWeather.tempMin : weeklyWeatherList[index].tempMin}°', style: Theme.of(context).textTheme.bodyText2,),
                      Text('${index==0 ? currentWeather.tempMax : weeklyWeatherList[index].tempMax}°', style: Theme.of(context).textTheme.bodyText2,),
                    ],
                  )
                )
              ],
            ),
          );
        },
        childCount: weeklyWeatherList.length
      ),
    );
  }
}