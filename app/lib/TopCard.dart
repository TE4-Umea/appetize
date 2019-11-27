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
          if (vegFood.value.length == 0) topCardExpanded.value = false;
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
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              restaurants[restaurant.value].logo,
                              width: 300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              eatTime.value +
                                  (regFood.value.length > 0 ? " - " : "") +
                                  regFood.value +
                                  "\n" +
                                  vegFood.value,
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Visibility(
                              child: Padding(
                                child: Icon(
                                    value
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                    color: Colors.white),
                                padding: EdgeInsets.only(left: 0, bottom: 20),
                              ),
                              visible: vegFood.value.length > 0,
                            )
                          ],
                        ),
                      ),
                      width: width - 25,
                      top: textTop,
                    ),
                    Positioned(
                      child: FloatingActionButton(
                          child: Icon(
                            Icons.menu,
                            size: 35,
                          ),
                          onPressed: () {
                            navigatorKey.currentState.pushNamed('/settings');
                          },
                          elevation: 0,
                          backgroundColor:
                              restaurants[restaurant.value].darkColor),
                      right: 20,
                      bottom: 3,
                    ),
                  ],
                ),
              );
            }));
  }
}
