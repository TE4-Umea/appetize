import 'package:flutter/material.dart';

class ComplaintCard extends StatefulWidget {
  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              padding: EdgeInsets.all(20),
            ),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          Container(
            height: 7,
            color: Colors.blue,
          )
        ],
      ),
      padding: EdgeInsets.all(30),
    );
  }
}
