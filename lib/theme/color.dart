import 'package:flutter/material.dart';

class CustomColor {
  static MaterialColor getWeatherColor(String icon) {
    if(icon.substring(icon.length-1) == "n") return color_n;
    switch (icon) {
      case "01d": 
        return color_01d; break;
      case "02d": 
        return color_02d; break;
      case "03d":
      case "10d":
        return color_03d; break;
      case "04d": 
      case "11d":
        return color_04d; break;
      case "09d": 
      case "13d":
      case "50d":
        return color_09d; break;
      default:
        return color_04d; break;
    }
  }

  static const MaterialColor blue = MaterialColor(
    0xFF1E88E5,
    <int, Color>{
      50: Color(0xFF1E88E5),
      100: Color(0xFF1E88E5),
      200: Color(0xFF1E88E5),
      300: Color(0xFF1E88E5),
      400: Color(0xFF1E88E5),
      500: Color(0xFF1E88E5),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1E88E5),
      800: Color(0xFF1E88E5),
      900: Color(0xFF1E88E5),
    }
  );

  static const MaterialColor color_01d = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: Color(0xFF2196F3),
      100: Color(0xFF2196F3),
      200: Color(0xFF2196F3),
      300: Color(0xFF2196F3),
      400: Color(0xFF2196F3),
      500: Color(0xFF2196F3),
      600: Color(0xFF2196F3),
      700: Color(0xFF2196F3),
      800: Color(0xFF2196F3),
      900: Color(0xFF2196F3),
    }
  );

  static const MaterialColor color_02d = MaterialColor(
    0xFF1E88E5,
    <int, Color>{
      50: Color(0xFF1E88E5),
      100: Color(0xFF1E88E5),
      200: Color(0xFF1E88E5),
      300: Color(0xFF1E88E5),
      400: Color(0xFF1E88E5),
      500: Color(0xFF1E88E5),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1E88E5),
      800: Color(0xFF1E88E5),
      900: Color(0xFF1E88E5),
    }
  );

  static const MaterialColor color_03d = MaterialColor(
    0xFF2286C3,
    <int, Color>{
      50: Color(0xFF2286C3),
      100: Color(0xFF2286C3),
      200: Color(0xFF2286C3),
      300: Color(0xFF2286C3),
      400: Color(0xFF2286C3),
      500: Color(0xFF2286C3),
      600: Color(0xFF2286C3),
      700: Color(0xFF2286C3),
      800: Color(0xFF2286C3),
      900: Color(0xFF2286C3),
    }
  );

  static const MaterialColor color_04d = MaterialColor(
    0xFF006DB3,
    <int, Color>{
      50: Color(0xFF006DB3),
      100: Color(0xFF006DB3),
      200: Color(0xFF006DB3),
      300: Color(0xFF006DB3),
      400: Color(0xFF006DB3),
      500: Color(0xFF006DB3),
      600: Color(0xFF006DB3),
      700: Color(0xFF006DB3),
      800: Color(0xFF006DB3),
      900: Color(0xFF006DB3),
    }
  );

  static const MaterialColor color_09d = MaterialColor(
    0xFF62757F,
    <int, Color>{
      50: Color(0xFF62757F),
      100: Color(0xFF62757F),
      200: Color(0xFF62757F),
      300: Color(0xFF62757F),
      400: Color(0xFF62757F),
      500: Color(0xFF62757F),
      600: Color(0xFF62757F),
      700: Color(0xFF62757F),
      800: Color(0xFF62757F),
      900: Color(0xFF62757F),
    }
  );

  static const MaterialColor color_n = MaterialColor(
    0xFF002171,
    <int, Color>{
      50: Color(0xFF002171),
      100: Color(0xFF002171),
      200: Color(0xFF002171),
      300: Color(0xFF002171),
      400: Color(0xFF002171),
      500: Color(0xFF002171),
      600: Color(0xFF002171),
      700: Color(0xFF002171),
      800: Color(0xFF002171),
      900: Color(0xFF002171),
    }
  );
}