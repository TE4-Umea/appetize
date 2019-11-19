import 'package:Appetize/API.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class RateBar extends StatefulWidget {
  Color color;

  RateBar(this.color);
  @override
  _RateBarState createState() => _RateBarState();
}

class _RateBarState extends State<RateBar> {
  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 10,
                )
              ]),
          width: MediaQuery.of(context).size.width - 50,
          child: Padding(
            child: Row(
              children: <Widget>[
                Smiley(3, widget.color),
                Smiley(2, widget.color),
                Smiley(1, widget.color),
                Smiley(0, widget.color),
              ],
            ),
            padding: EdgeInsets.all(20),
          )),
    );
  }
}

class Smiley extends StatefulWidget {
  int value;
  List smileys = [
    Icons.sentiment_dissatisfied,
    Icons.sentiment_neutral,
    Icons.sentiment_satisfied,
    Icons.sentiment_very_satisfied
  ];

  List colors = [
    Colors.red,
    Colors.orange,
    Colors.lightGreen[400],
    Colors.green
  ];

  Color color;

  Smiley(this.value, this.color);

  @override
  _SmileyState createState() => _SmileyState();
}

class _SmileyState extends State<Smiley> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 50 - (10 * 4)) / 4;
    return GestureDetector(
      child: ValueListenableBuilder<int>(
        builder: (context, value, _) {
          return Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                child: Icon(
                  widget.smileys[widget.value],
                  color: value == -1
                      ? widget.color
                      : (value == widget.value
                          ? widget.colors[widget.value]
                          : Colors.grey[800]),
                  size: width,
                ),
                top: value == widget.value ? -5 : 0,
                curve: Curves.easeOutExpo,
                left: 0,
              ),
              Container(
                height: width + 5,
                width: width,
              ),
            ],
          );
        },
        valueListenable: globals.foodRating,
      ),
      onTap: () {
        globals.foodRating.value = widget.value;
        globals.deliverStatus.value = 1;
        API.submitProfile();
      },
    );
  }
}
