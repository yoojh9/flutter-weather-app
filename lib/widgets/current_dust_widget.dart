import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import '../providers/dust.dart';
import '../theme/color.dart';

class CurrentDustWidget extends StatelessWidget {
  final Dust dust;

  CurrentDustWidget(this.dust);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(25),
        ),
        child: (dust==null || dust.pm10Grade==null)
          ? Container()
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('미세먼지:',style: Theme.of(context).textTheme.bodyText2,),
              Text('${dust.pm10GradeTxt}',style: Theme.of(context).textTheme.bodyText2.copyWith(color: DustColor.getDustColor(dust.pm10Grade), fontWeight: FontWeight.bold),),
              SizedBox(width: ScreenUtil().setWidth(12)),
              Text('초미세먼지:',style: Theme.of(context).textTheme.bodyText2,),
              Text('${dust.pm25GradeTxt}',style: Theme.of(context).textTheme.bodyText2.copyWith(color: DustColor.getDustColor(dust.pm25Grade), fontWeight: FontWeight.bold),),
            ],
          ),
      )
    );
  }
}