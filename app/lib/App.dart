import 'package:Appetize/FrontPage.dart';
import 'package:Appetize/SettingsPage.dart';
import 'package:Appetize/SplashPage.dart';
import 'package:Appetize/globals.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appetize',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => FrontPage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
