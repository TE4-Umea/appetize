import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class ComplaintButton extends StatefulWidget {
  @override
  ComplaintButtonState createState() => ComplaintButtonState();
}

const List<String> _complaints = [
  "Kall mat",
  "Lång kö",
  "Maten var inte god",
  "Dåliga tillbehör",
  "Slut på mat"
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
      ),
    );
  }

  void addComplaint(String value) {
    globals.complaints.value.add(value);
    globals.complaints.notifyListeners();
  }

  _askuser() {
    showDialog(
      context: context,
      child: new SimpleDialog(
        title: new Text('Lägg till'),
        children: <Widget>[
          for (String complaint in _complaints)
            SimpleDialogOption(
              onPressed: () {
                addComplaint(complaint);
                globals.navigatorKey.currentState.pop();
              },
              child: Text(complaint),
            ),
          SimpleDialogOption(
            onPressed: () {
              addComplaint('');
              globals.navigatorKey.currentState.pop();
            },
            child: Text('Egen text'),
          ),
        ],
      ),
    );
  }
}
