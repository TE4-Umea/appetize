import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ComplaintCard extends StatefulWidget {
  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    Padding(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Kommentar',
                            textScaleFactor: 1.5,
                            style: new TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white),
                      child: TextField(
                        maxLines: 1,
                        style: new TextStyle(
                            color: globals
                                .restaurants[globals.restaurant.value].color,
                            fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: globals.restaurants[globals.restaurant.value].darkColor,
                borderRadius: new BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: globals.restaurants[globals.restaurant.value].color,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
    );
  }
}
