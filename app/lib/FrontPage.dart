import 'dart:math';

import 'package:Appetize/API.dart';
import 'package:Appetize/FrontPageText.dart';
import 'package:Appetize/RateBar.dart';
import 'package:Appetize/ComplaintCard.dart';
import 'package:Appetize/Complaint.dart';
import 'package:Appetize/TopCard.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'globals.dart' as globals;

class FrontPage extends StatelessWidget {
  FrontPage();

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
                valueListenable: globals.restaurant,
                builder: (context, value, _) {
                  return Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 0,
                    runSpacing: 5,
                    children: <Widget>[
                      Padding(
                        child: TopCard(),
                        padding: EdgeInsets.only(top: 40),
                      ),
                      Padding(
                        child: FrontPageText(),
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Padding(
                        child: RateBar(globals.restaurants[value].color),
                        padding: EdgeInsets.only(top: 10),
                      ),
                      ComplaintButton(),
                      ComplaintCard(),
                      MaterialButton(
                        child: Text('LOGGA UT (ENDAST FÖR TEST)'),
                        color: Colors.white,
                        onPressed: () {
                          API.logout();
                        },
                      )
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
