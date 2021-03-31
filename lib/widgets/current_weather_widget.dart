import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../providers/current_weather.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final CurrentWeather currentWeather;

  CurrentWeatherWidget(this.currentWeather);



  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: ScreenUtil().setHeight(320),
        child: Column(
          children: [
              FittedBox(
                child: Text('${currentWeather.description == null ? '-' :  currentWeather.description}',  
                style: Theme.of(context).textTheme.headline4, 
                textAlign: TextAlign.center,)
              ),
              currentWeather.icon == null 
                ? Container() 
                : Image.asset('assets/images/weather/${currentWeather.icon}.png', height: ScreenUtil().setHeight(120),),
              Text('${currentWeather.temp == null ? ' ': currentWeather.temp}°',  style: Theme.of(context).textTheme.headline1,),
              Text('최고:${currentWeather.tempMax == null ? ' ' : currentWeather.tempMax}°   최저:${currentWeather.tempMin == null ? ' ' :currentWeather.tempMin}°', 
                style: Theme.of(context).textTheme.bodyText2,)
          ],
        ),
      ),
    );
  }
}