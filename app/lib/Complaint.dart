import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class ComplaintButton extends StatefulWidget {
  @override
  ComplaintButtonState createState() => ComplaintButtonState();
}

class ComplaintButtonState extends State<ComplaintButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      child: ButtonTheme(
        child: RaisedButton(
          elevation: 10,
          child: Text('Lägg till klagomål eller kommentar'),
          color: Colors.grey[50],
          onPressed: () {},
          textColor:
              globals.restaurants[globals.choosenRestaurant.value].darkColor,
        ),
        height: 50,
        minWidth: MediaQuery.of(context).size.width - 200,
      ),
      padding: EdgeInsets.all(15),
    ));
  }
}
