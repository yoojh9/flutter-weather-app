import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../providers/daily_weather.dart';

class DailyWeatherList extends StatelessWidget {
  List<DailyWeather> dailyWeatherList;

  DailyWeatherList(this.dailyWeatherList);


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
                  child: Text('${dailyWeatherList[index].day}', style: Theme.of(context).textTheme.bodyText2,)
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/weather/${dailyWeatherList[index].icon}.png',  height: ScreenUtil().setHeight(30),)
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${dailyWeatherList[index].tempMin}°', style: Theme.of(context).textTheme.bodyText2,),
                      Text('${dailyWeatherList[index].tempMax}°', style: Theme.of(context).textTheme.bodyText2,),
                    ],
                  )
                )
              ],
            ),
          );
        },
        childCount: dailyWeatherList.length
      ),
    );
  }
}