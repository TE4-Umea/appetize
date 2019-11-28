import 'package:flutter/material.dart';
import 'package:Appetize/globals.dart' as globals;

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
                String text = "Din input har skickats till servern!";
                IconData icon = Icons.done_all;
                Color color = Colors.green;

                if (globals.deliverStatus.value == 0) {
                  text = "Kan inte ansluta till servern!";
                  icon = Icons.sms_failed;
                  color = Colors.red;
                } else if (globals.deliverStatus.value == 1) {
                  text = "Din input skickas till servern!";
                  icon = Icons.done;
                  color = Colors.orange;
                }

                return Tooltip(
                  child: Row(
                    children: <Widget>[
                      Text(
                        globals.statusText.value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Visibility(
                        child: Padding(
                          child: Icon(
                            icon,
                            color: color,
                          ),
                          padding: EdgeInsets.only(left: 5),
                        ),
                        visible: globals.foodRating.value != -1,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  message: text,
                );
              },
              valueListenable: globals.deliverStatus,
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                '${days[date.weekday - 1]}, ${date.day}${date.day > 2 ? 'e' : 'a'}',
                style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              ),
            )
          ],
        ),
        padding: EdgeInsets.only(top: 10),
      ),
    );
  }
}
