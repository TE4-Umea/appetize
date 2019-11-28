import 'package:Appetize/colors.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ConnectingPage extends StatefulWidget {
  @override
  ConnectingPageState createState() => ConnectingPageState();
}

class ConnectingPageState extends State<ConnectingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              child: Container(
                child: FlareActor(
                  "assets/loading.flr",
                  animation: 'loading',
                  fit: BoxFit.contain,
                ),
                width: MediaQuery.of(context).size.width - 100,
                height: 200,
              ),
              padding: EdgeInsets.only(top: 100),
            ),
          ),
          Text('Ansluter till AppetizeNET'),
        ],
      ),
    );
  }
}
