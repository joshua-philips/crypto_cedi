// Crypto Cedi Colors
// #ff3501 - Red Arrow
// #43b41b - Green Arrow
// #1c1b1a - Black
// #413b2c - Brown for search
// #707070 - Grey for crypto card
// #edb532 - Yellow
// #000000 - Black

import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.yellow,
  primaryColor: Color(0xffedb532),
  accentColor: Color(0xff413b2c),
  scaffoldBackgroundColor: Color(0xffedb532),
  textTheme: TextTheme(
    bodyText2: TextStyle(
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xffedb532),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  cardTheme: CardTheme(
    elevation: 0.5,
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  accentColor: Colors.redAccent,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

class ThemeNotifier extends ChangeNotifier {}
