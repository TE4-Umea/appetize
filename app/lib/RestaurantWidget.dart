import 'package:flutter/material.dart';
import 'colors.dart';
import 'Restaurant.dart';

class RestaurantWidget extends StatefulWidget {
  Restaurant restaurant;
  RestaurantWidget(this.restaurant);

  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double checkMarkWidth = 40;
    // Restaurant block
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: widget.restaurant.darkColor,
            height: 138,
          ),
          Container(
            color: widget.restaurant.color,
            height: 130,
          ),
          Center(
            child: Padding(
              // Logo
              child: Image.asset(
                widget.restaurant.logo,
                scale: 6,
              ),
              padding: EdgeInsets.only(top: 10),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: 110, left: (width / 4) - checkMarkWidth / 2),
              child: Visibility(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.restaurant.color,
                      border: Border.all(color: backgroundColor, width: 5)),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  /* color: widget.color, */
                  constraints: BoxConstraints.tight(
                    Size(checkMarkWidth, checkMarkWidth),
                  ),
                  /* shape: CircleBorder(), */
                ),
                visible: true,
              )),
        ],
      ),
      width: width * .5,
      height: 150,
    );
  }
}
