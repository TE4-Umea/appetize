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
    /* SystemChrome.setEnabledSystemUIOverlays([]); */
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}
