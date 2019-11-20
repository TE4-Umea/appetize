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
                          ),
                          Icon(Icons.clear),
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
                        style: new TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2.0,
                    color: globals.restaurants[globals.restaurant.value].color),
              ),
            ),
            Container(
              height: 7,
              color: globals.restaurants[globals.restaurant.value].color,
            ),
          ],
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
    );
  }
}
