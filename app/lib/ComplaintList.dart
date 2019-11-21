import 'package:Appetize/ComplaintCard.dart';
import 'package:flutter/cupertino.dart';
import 'globals.dart' as globals;

class ComplaintList extends StatefulWidget {
  @override
  _ComplaintListState createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
        builder: (context, value, _) {
          return Column(
            children: <Widget>[
              for (var complaint in value) ComplaintCard(complaint)
            ],
          );
        },
        valueListenable: globals.complaints,
      ),
    );
  }
}
