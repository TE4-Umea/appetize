import 'package:flutter/material.dart';
import 'globals.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Text('Inställningar')
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
                onPressed: () {},
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
