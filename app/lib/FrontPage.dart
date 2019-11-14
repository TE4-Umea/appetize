import 'dart:math';

import 'package:appetize/RateBar.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'RestaurantWidget.dart';
import 'globals.dart' as globals;

class FrontPage extends StatelessWidget {
  Map restaurants;
  FrontPage(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          // Body
          children: <Widget>[
            new Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 0,
              runSpacing: 5,
              children: <Widget>[
                RestaurantWidget(restaurants['greek']),
                RestaurantWidget(restaurants['olearys']),
                Center(
                    child: Padding(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Hur var maten idag?',
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Torsdag, 14e',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 10),
                )),
                Padding(
                  child: RateBar(restaurants['olearys'].color),
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
