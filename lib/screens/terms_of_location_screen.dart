import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import './weather_screen.dart';

class TermOfLocationScreen extends StatefulWidget {

  @override
  _TermOfLocationScreenState createState() => _TermOfLocationScreenState();
}

class _TermOfLocationScreenState extends State<TermOfLocationScreen> {

  void _back(){
    Navigator.of(context).pushReplacementNamed(WeatherScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS 
      ? CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('버전정보'),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          leading: GestureDetector(
            child: Icon(CupertinoIcons.back,),
            onTap: _back,
          ), 
        ),
        child: _contentBody(context),
      )
      : Scaffold(
        appBar: AppBar(
          title: Text("버전정보"),
          leading: IconButton(icon: Icon(Icons.arrow_back) , onPressed: _back,),    
          backgroundColor: Colors.transparent,
        ),
        body: _contentBody(context),
      );
  }

  Widget _contentBody(BuildContext ctx){

  }
}