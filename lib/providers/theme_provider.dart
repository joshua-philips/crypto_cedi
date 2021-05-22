// Crypto Cedi Colors
// #ff3501 - Red Arrow
// #43b41b - Green Arrow
// #1c1b1a - Black
// #413b2c - Brown for search
// #707070 - Grey for crypto card
// #edb532 - Yellow
// #000000 - Black

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.yellow,
  primaryColor: Colors.yellow[200], // Color(0xffedb532),
  accentColor: Color(0xff413b2c),
  scaffoldBackgroundColor: Colors.white, // Color(0xffedb532),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.raleway(
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
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
    color: Colors.grey[200],
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.yellow,
  accentColor: Color(0xffedb532),
  scaffoldBackgroundColor: Color(0Xff1c1b1a),
  textTheme: TextTheme(
    bodyText2: GoogleFonts.raleway(
      color: Colors.white,
    ),
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
  cardTheme: CardTheme(
    elevation: 0.5,
    color: Colors.grey[850],
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String prefKey = 'theme';
  SharedPreferences _sharedPreferences;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    initPrefs();
    _darkTheme = false;
    loadFromPrefs();
  }

  Future initPrefs() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  Future loadFromPrefs() async {
    await initPrefs();
    _darkTheme = _sharedPreferences.getBool(prefKey) ?? false;
    notifyListeners();
  }

  Future saveToPrefs() async {
    await initPrefs();
    _sharedPreferences.setBool(prefKey, _darkTheme);
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    saveToPrefs();
    notifyListeners();
  }
}
