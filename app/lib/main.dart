import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(FrontPage());
}

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/olearys.png",
              ),
              Image.asset(
                "assets/greek.png",
              )
            ],
          ),
          padding: EdgeInsets.all(50),
        ),
      ),
    );
  }
}
