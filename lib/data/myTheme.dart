// ignore_for_file: file_names, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class myTheme {
  //---------------------------light theme ----------------------------------------

  static final myLightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      scaffoldBackgroundColor: Color(0xffF0F8FF),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        // primary: Color(0xffF0F8FF),
        primary: Color(0xfff1404b),
        primaryVariant: Colors.red,
        //onPrimary: Color(0xfff1404b),
        onPrimary: Colors.black,
        secondary: Colors.purpleAccent,
        secondaryVariant: Colors.purple,
        onSecondary: Colors.grey.shade200,
        // background: Color(0xff1D201F),
        background: Colors.blue,
        onBackground: Colors.blueAccent,
        error: Colors.redAccent,
        onError: Colors.red,
        surface: Colors.white,
        onSurface: Colors.black26,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xfff1404b),
      ));
  //---------------------------Dark theme ----------------------------------------
  static final myDarkTheme = ThemeData(
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
    ),
    scaffoldBackgroundColor: Color(0xff0f0f0f),
    colorScheme: ColorScheme.dark(
      brightness: Brightness.light,
      // primary: Color(0xffF0F8FF),
      primary: Color(0xfff1404b),
      primaryVariant: Colors.red,
      //onPrimary: Color(0xfff1404b),
      onPrimary: Colors.black,
      secondary: Colors.purpleAccent,
      secondaryVariant: Colors.purple,
      onSecondary: Colors.grey.shade200,
      // background: Color(0xff1D201F),
      background: Colors.blue,
      onBackground: Colors.blueAccent,
      error: Colors.redAccent,
      onError: Colors.red,
      surface: Colors.white,
      onSurface: Colors.black26,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      sizeConstraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 50,
        minHeight: 50,
        minWidth: 50,
      ),
      backgroundColor: Color(0xfff1404b),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      foregroundColor: Colors.grey.shade900,
      splashColor: Colors.pink,
    ),
  );
}
