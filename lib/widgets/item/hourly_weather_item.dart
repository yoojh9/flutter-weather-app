import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class HourlyWeatherItem extends StatelessWidget {
  final int index;
  final String hour;
  final String icon;
  final int temperature;

  HourlyWeatherItem(this.index, this.hour, this.icon, this.temperature);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ScreenUtil().setWidth(65),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(index==0 ? '지금' : '$hour시', style: Theme.of(context).textTheme.bodyText2,),
          Image.asset('assets/images/weather/$icon.png', height: ScreenUtil().setHeight(30),),
          FittedBox(
            child:  Text('${temperature.toString()}°', style: Theme.of(context).textTheme.bodyText2,),
          )
         
        ]
      )
    );
  }
}