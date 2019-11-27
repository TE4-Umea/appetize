import 'package:Appetize/pages/FrontPage.dart';
import 'package:Appetize/pages/MorePage.dart';
import 'package:Appetize/pages/SplashPage.dart';
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
        '/settings': (context) => MorePage(),
      },
    );
  }
}
