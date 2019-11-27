import 'package:Appetize/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:Appetize/globals.dart';
import 'package:Appetize/API.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _confirmLogout() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.warning),
                ),
                Text("Logga ut")
              ],
            ),
            content: new Text(
                "Om du loggar ut behöver du en ny inbjudningskod för att använda appen igen!"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  "Logga ut",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  API.logout();
                },
              ),
              new FlatButton(
                child:
                    new Text("Avbryt", style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: restaurants[restaurant.value].color,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/icon_white.png',
              height: 40,
            ),
            Text('Extra')
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            child: SettingsList(),
            padding: EdgeInsets.only(top: 30),
          ),
          Padding(
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  /* API.logout(); */
                  _confirmLogout();
                },
                color: restaurants[restaurant.value].color,
                height: 50,
                minWidth: MediaQuery.of(context).size.width - 10,
                child: Text(
                  'Logga ut',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
        ],
      ),
    );
  }
}

class SettingsList extends StatefulWidget {
  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: <Widget>[
            Text(
              'Specialkost',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              children: <Widget>[
                Text('Vegetarian'),
                ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Checkbox(
                        value: value,
                        onChanged: (val) {
                          vegetarian.value = val;
                          savePreferences();
                        },
                      );
                    },
                    valueListenable: vegetarian)
              ],
            ),
            Row(
              children: <Widget>[
                Text('Glutenintolerans'),
                ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Checkbox(
                        value: value,
                        onChanged: (val) {
                          gluten.value = val;
                          savePreferences();
                        },
                      );
                    },
                    valueListenable: gluten)
              ],
            )
          ],
        ),
      ),
    );
  }
}
