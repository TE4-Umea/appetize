import 'package:Appetize/globals.dart';
import 'package:flutter/material.dart';

class TopCard extends StatefulWidget {
  @override
  _TopCardState createState() => _TopCardState();
}

class _TopCardState extends State<TopCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double borderRadius = 10;
    double iconWidth = 70;
    double iconTop = 15;
    double textTop = 110;
    double height = 135;
    double lipHeight = 30;

    double expandedHeight = 160;

    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          topCardExpanded.value = !topCardExpanded.value;
        },
        child: ValueListenableBuilder(
            valueListenable: topCardExpanded,
            builder: (context, value, _) {
              return Center(
                child: Stack(
                  children: <Widget>[
                    AnimatedSize(
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                        width: width - 25,
                        height: topCardExpanded.value ? expandedHeight : height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              borderRadius,
                            ),
                            color: restaurants[restaurant.value].darkColor),
                      ),
                      duration: Duration(milliseconds: 300),
                      vsync: this,
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
                              width: 180,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Container(
                        child: Text(
                          '11:20 - Pizza med kött...\nVeg: Margerita',
                          textAlign: TextAlign.center,
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
            }));
  }
}
