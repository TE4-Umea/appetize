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

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      API.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        child: Column(
          // Body
          children: <Widget>[
            ValueListenableBuilder(
              valueListenable: globals.restaurant,
              builder: (context, value, _) {
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        child: Container(
                          /* color: Colors.black.withOpacity(.5), */
                          height: MediaQuery.of(context).size.height - 175,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  child: FrontPageText(),
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Padding(
                                  child:
                                      RateBar(globals.restaurants[value].color),
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                ComplaintButton(),
                                ComplaintList(),
                              ],
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(top: 175),
                      ),
                      ValueListenableBuilder(
                          builder: (context, value, _) {
                            return Visibility(
                              child: Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Stängt!',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                                      Padding(
                                        child: Text(
                                          'Öppetider:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        padding: EdgeInsets.only(top: 20),
                                      ),
                                      Text(
                                        'Vardagar 11:00 - 14:00',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  color: Colors.black.withOpacity(.9),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                ),
                              ),
                              visible: !value,
                            );
                          },
                          valueListenable: globals.open),
                      Padding(
                        child: TopCard(),
                        padding: EdgeInsets.only(top: 40),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
      ),
    );
  }
}
