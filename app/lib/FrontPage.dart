import 'package:appetize/Restaurant.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'RestaurantWidget.dart';

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
/*                 LineChart(
                  LineChartData(),
                ), */
              ],
            )
          ],
        ),
      ),
    );
  }
}
