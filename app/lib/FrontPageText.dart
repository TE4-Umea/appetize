import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class FrontPageText extends StatelessWidget {
  DateTime date = new DateTime.now();
  List<String> days = ['Måndag', 'Tisdag', 'Onsdag', 'Torsdag', 'Fredag'];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        child: Column(
          children: <Widget>[
            ValueListenableBuilder(
              builder: (context, value, _) {
                return Text(
                  value == -1
                      ? 'Hur var maten idag?'
                      : 'Tack för din feedback!',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                );
              },
              valueListenable: globals.foodRating,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '${days[date.weekday - 1]}, ${date.day}${date.day > 2 ? 'e' : 'a'}',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
        padding: EdgeInsets.only(top: 10),
      ),
    );
  }
}
