import 'package:Appetize/globals.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  @override
  _TopCardState createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> {
  @override
  Widget build(BuildContext context) {
    double borderRadius = 10;
    double iconWidth = 70;
    double iconTop = 15;
    double textTop = 110;
    double height = 135;
    double lipHeight = 30;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            width: width - 25,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                color: restaurants[restaurant.value].darkColor),
          ),
          Container(
            width: width - 25,
            height: height - lipHeight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  borderRadius,
                ),
                color: restaurants[restaurant.value].color),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    'assets/icon_white.png',
                    width: iconWidth,
                  ),
                  top: iconTop,
                  left: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    restaurants[restaurant.value].logo,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Container(
              child: Text(
                '11:20',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              alignment: Alignment.bottomCenter,
              width: width - 25,
            ),
            top: textTop,
          ),
        ],
      ),
    );
  }
}
