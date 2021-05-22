import 'package:crypto_cedi/home_page.dart';
import 'package:crypto_cedi/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (BuildContext context, notifier, Widget child) {
          return MaterialApp(
            title: 'Crypto Cedi',
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme ? dark : light,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
