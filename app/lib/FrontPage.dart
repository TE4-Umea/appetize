import 'dart:math';

import 'package:Appetize/Complaint.dart';
import 'package:Appetize/ComplaintCard.dart';
import 'package:Appetize/FrontPageText.dart';
import 'package:Appetize/RateBar.dart';
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
        body: GestureDetector(
          child: Column(
            // Body
            children: <Widget>[
              ValueListenableBuilder(
                valueListenable: globals.choosenRestaurant,
                builder: (context, value, _) {
                  return Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 0,
                    runSpacing: 5,
                    children: <Widget>[
                      GestureDetector(
                        child: RestaurantWidget(restaurants['greek']),
                        onTap: () {
                          globals.choosenRestaurant.value = 'greek';
                        },
                      ),
                      GestureDetector(
                        child: RestaurantWidget(restaurants['olearys']),
                        onTap: () {
                          globals.choosenRestaurant.value = 'olearys';
                        },
                      ),
                      FrontPageText(),
                      Padding(
                        child: RateBar(globals.restaurants[value].color),
                        padding: EdgeInsets.only(top: 10),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        ),
      ),
    );
  }
}
