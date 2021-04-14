import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation _animation;

    @override
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    super.initState();  
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/048-umbrella.png', height: ScreenUtil().setHeight(150)),
            SizedBox(height: ScreenUtil().setHeight(10)),
            FadeTransition(
              opacity: _animation,
              child: Text('Loading...', style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenUtil().setSp(20),
                fontWeight: FontWeight.w600,
                color: Colors.black54
              ),
              textAlign: TextAlign.center,
             )
            )
          ]
        ),
      );
  }
}