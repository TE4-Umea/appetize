import 'package:flutter/material.dart';

class ComplaintCard extends StatefulWidget {
  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Container(
        child: Padding(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: TextField(maxLines: 2),
          ),
          padding: EdgeInsets.all(20),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey),
      ),
      padding: EdgeInsets.all(30),
    );
  }
}
