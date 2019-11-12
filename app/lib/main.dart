import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Restaurant {
  String logo, name;
  Color color, darkColor;
  Restaurant(this.name, this.logo);
}

Map restaurants = {
  'greek': Restaurant('Greek Grill', 'assets/greek.png'),
  'olearys': Restaurant("O'learys", 'assets/olearys.png')
};

void main() {
  restaurants['greek'].color = Color.fromRGBO(84, 130, 255, 1);
  restaurants['greek'].darkColor = Color.fromRGBO(59, 96, 196, 1);
  restaurants['olearys'].color = Color.fromRGBO(45, 151, 132, 1);
  restaurants['olearys'].darkColor = Color.fromRGBO(30, 105, 91, 1);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));
  runApp(FrontPage());
}

class FrontPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          // Body
          children: <Widget>[
            new Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 0,
              runSpacing: 5,
              children: <Widget>[
                RestaurantWidget(restaurants['greek']),
                RestaurantWidget(restaurants['olearys']),
              ],
            )
          ],
        ),
      ),
    );
  }
}

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
                      border: Border.all(color: Colors.white, width: 5)),
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
