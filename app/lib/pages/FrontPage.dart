import 'dart:math';

import 'package:Appetize/API.dart';
import 'package:Appetize/Complaint/ComplaintList.dart';
import 'package:Appetize/pages/FrontPageText.dart';
import 'package:Appetize/RateBar.dart';
import 'package:Appetize/Complaint/ComplaintCard.dart';
import 'package:Appetize/Complaint/ComplaintButton.dart';
import 'package:Appetize/TopCard.dart';
import 'package:flutter/material.dart';
import 'package:Appetize/colors.dart';
import 'package:Appetize/globals.dart' as globals;

class FrontPage extends StatelessWidget {
  FrontPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: GestureDetector(
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
                        ComplaintList()
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
      ),
    );
  }
}