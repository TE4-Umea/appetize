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
    void _askIfHasNotifiedStaff() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Icon(
                  Icons.assignment_late,
                  color:
                      globals.notifiedStaff.value ? Colors.green : Colors.red,
                ),
              ],
            ),
            content:
                new Text("Har du kontaktat personalen angående kommentaren?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Ja",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  globals.notifiedStaff.value = true;
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Nej", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  globals.notifiedStaff.value = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    void addComplaint(String value) {
      globals.navigatorKey.currentState.pop();

      // Make sure not to submit duplicates
      if (value == null) return;
      if (value.length == 0) return;
      if (globals.complaints.value.indexOf(value) == -1)
        globals.complaints.value.add(value);
      globals.complaints.notifyListeners();

      if (globals.complaints.value.length == 1 && !globals.notifiedStaff.value)
        _askIfHasNotifiedStaff();
    }

    void _writeCustomComplaint() {
      String _customComplaint;
      showDialog(
        context: context,
        builder: (_) => new SimpleDialog(
          title: new Text('Lägg till kommentar'),
          children: <Widget>[
            Padding(
              child: TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: "Kommentar..."),
                onChanged: (value) {
                  _customComplaint = value;
                },
              ),
              padding: EdgeInsets.all(20),
            ),
            Padding(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    child: Text('Avbryt'),
                    onPressed: () {
                      globals.navigatorKey.currentState.pop();
                    },
                  ),
                  MaterialButton(
                    child: Text('Lägg till'),
                    onPressed: () {
                      addComplaint(_customComplaint);
                    },
                  ),
                ],
              ),
              padding: EdgeInsets.only(right: 15),
            )
          ],
        ),
      );
    }

    void _askuser() {
      showDialog(
        context: context,
        builder: (_) => new SimpleDialog(
          title: new Text('Lägg till kommentar'),
          children: <Widget>[
            for (String complaint in _complaints)
              SimpleDialogOption(
                onPressed: () {
                  addComplaint(complaint);
                },
                child: Text(
                  complaint,
                  style: TextStyle(fontSize: 17),
                ),
              ),
            SimpleDialogOption(
              onPressed: () {
                globals.navigatorKey.currentState.pop();
                _writeCustomComplaint();
              },
              child: Text(
                'Egen text',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            child: ButtonTheme(
              child: ValueListenableBuilder(
                  valueListenable: globals.foodRating,
                  builder: (context, value, _) {
                    return Row(
                      children: <Widget>[
                        FlatButton(
                          /* elevation: 2, */
                          child: Text('Lägg till kommentar'),
                          color: null,
                          onPressed: () {
                            _askuser();
                          },
                          textColor: value != -1
                              ? globals.smileyColors[value]
                              : globals
                                  .restaurants[globals.restaurant.value].color,
                        ),
                        ValueListenableBuilder(
                          builder: (context, value, _) {
                            return Visibility(
                                child: ValueListenableBuilder(
                                  builder: (context, value, _) {
                                    return IconButton(
                                      icon: Icon(value
                                          ? Icons.assignment_turned_in
                                          : Icons.assignment_late),
                                      color: value ? Colors.green : Colors.red,
                                      onPressed: () {
                                        _askIfHasNotifiedStaff();
                                      },
                                    );
                                  },
                                  valueListenable: globals.notifiedStaff,
                                ),
                                visible: value.length > 0);
                          },
                          valueListenable: globals.complaints,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    );
                  }),
              height: 50,
              minWidth: MediaQuery.of(context).size.width - 200,
            ),
            padding: EdgeInsets.all(5),
          ),
          // Text('Ditt klagomål är: ${_complaint}')
        ],
      ),
    );
  }
}
