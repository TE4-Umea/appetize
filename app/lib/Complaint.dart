import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ComplaintButton extends StatefulWidget {
  @override
  ComplaintButtonState createState() => ComplaintButtonState();
}

const List<String> _complaints = [
  "Kall mat",
  "Lång kö",
  "Maten var inte god",
  "Dåliga tillbehör",
  "ree"
];

class ComplaintButtonState extends State<ComplaintButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Padding(
          child: ButtonTheme(
            child: RaisedButton(
              elevation: 2,
              child: Text('Lägg till klagomål eller kommentar'),
              color: Colors.white,
              onPressed: () {
                globals.foodRating.value = -1;
                _askuser();
              },
              textColor: globals.restaurants[globals.restaurant.value].color,
            ),
            height: 50,
            minWidth: MediaQuery.of(context).size.width - 200,
          ),
          padding: EdgeInsets.all(20),
        ),
        // Text('Ditt klagomål är: ${_complaint}')
      ],
    ));
  }

  String _complaint = '';

  void addComplaint(String value) {}

  Future<Null> _askuser() async {
    switch (await showDialog(
      context: context,
      child: new SimpleDialog(
        title: new Text('Klagomål / kommentar'),
        children: <Widget>[
          for (String complaint in _complaints)
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(complaint),
            ),
        ],
      ),
    )) {
      /* 
      case Complaint.ColdFood:
        setComplaint('Kall Mat');
        break;
      case Complaint.LongLine:
        setComplaint('Lång Kö');
        break;
      case Complaint.NotTasty:
        setComplaint('Maten var inte god');
        break;
      case Complaint.NoSides:
        setComplaint('Dåliga tillbehör');
        break; */
    }
  }
}
