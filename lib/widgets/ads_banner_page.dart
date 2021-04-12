
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../models/ad_helper.dart';
import 'package:flutter_screenutil/screen_util.dart';


class AdsBannerPage extends StatefulWidget {
  @override
  _AdsBannerPageState createState() => _AdsBannerPageState();
}

class _AdsBannerPageState extends State<AdsBannerPage> {
  BannerAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      // ToDo Release 코드로 변경 필요
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: AdListener(
        onAdLoaded: (_) {
          setState((){
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        }
      )
    );
    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _isAdLoaded 
      ? Container(
          margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
          child: Container(
            alignment: Alignment.center,
            child: AdWidget(ad: _ad),
            width: _ad.size.width.toDouble(),
            height: _ad.size.height.toDouble(),
          ),
      )
      : Container()
    );
  }
}