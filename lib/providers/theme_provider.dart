import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.yellow,
  primaryColor: Colors.white,
  accentColor: Color(0xffedb532),
  scaffoldBackgroundColor: Colors.white,
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
  cardTheme: CardTheme(
    elevation: 0.5,
    color: Colors.grey[200],
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
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
  cardTheme: CardTheme(
    elevation: 0.5,
    color: Colors.grey[850],
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
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
