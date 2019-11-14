import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                Padding(
                  child: RateBar(restaurants['olearys'].color),
                  padding: EdgeInsets.only(top: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RateBar extends StatefulWidget {
  Color color;

  RateBar(this.color);
  @override
  _RateBarState createState() => _RateBarState();
}

class _RateBarState extends State<RateBar> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                )
              ]),
          width: MediaQuery.of(context).size.width - 50,
          child: Padding(
            child: Row(
              children: <Widget>[
                Smiley(3, widget.color),
                Smiley(2, widget.color),
                Smiley(1, widget.color),
                Smiley(0, widget.color),
              ],
            ),
            padding: EdgeInsets.all(20),
          )),
    );
  }
}

class Smiley extends StatefulWidget {
  int value;
  List smileys = [
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied
  ];

  List colors = [];

  Color color;

  Smiley(this.value, this.color);

  @override
  _SmileyState createState() => _SmileyState();
}

class _SmileyState extends State<Smiley> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Icon(
          widget.smileys[widget.value],
          color: widget.color,
          size: (MediaQuery.of(context).size.width - 50 - (10 * 4)) / 4,
        ),
      ),
      onTap: () {
        setState(() {
          widget.color = Colors.red;
        });
      },
    );
  }
}
