import 'package:Appetize/Complaint/ComplaintCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:Appetize/globals.dart' as globals;

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
              for (var i = 0; i < value.length; i++) ComplaintCard(value[i], i)
            ],
          );
        },
        valueListenable: globals.complaints,
      ),
    );
  }
}
