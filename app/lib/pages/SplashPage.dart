import 'package:Appetize/colors.dart';
import 'package:Appetize/globals.dart';
import 'package:flutter/material.dart';
import 'package:Appetize/API.dart';

class SplashPage extends StatelessWidget {
  SplashPage();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    child: Image.asset(
                      'assets/icon_transparent.png',
                      width: 200,
                    ),
                    padding: EdgeInsets.only(top: 20),
                  ),
                ),
                Padding(
                  child: Text(
                    'Skriv in din klasskod',
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Center(
                  child: CodeInput(),
                ),
                Padding(
                  child: ValueListenableBuilder(
                    builder: (context, value, _) {
                      return Text(
                        value,
                        style: TextStyle(color: Colors.red),
                      );
                    },
                    valueListenable: signupStatus,
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
}

class CodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 150,
      child: TextField(
        onChanged: (value) {
          if (value.length >= 4) {
            API.signup(value.toUpperCase());
          } else {
            signupStatus.value = '';
          }
        },
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(hintText: 'KOD'),
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
