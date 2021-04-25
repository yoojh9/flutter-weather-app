import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class FooterWidget extends StatelessWidget {
  bool isKor;

  FooterWidget(this.isKor);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: isKor
            ? Container(
                //height: ScreenUtil().setHeight(30),
                margin: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(15),
                ),
                child: Text(
                  '데이터는 실시간 관측된 자료이며, 측정소 현지 사정이나 \n데이터의 수신 상태에 따라 미수신 될 수 있음. \n 출처: 에어코리아',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.normal,
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            : Container());
  }
}
