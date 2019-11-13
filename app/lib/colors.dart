import 'package:flutter/material.dart';

Color backgroundColor = Color.fromRGBO(237, 237, 237, 1);

void setRestaurantColors(Map restaurants) {
  restaurants['greek'].color = Color.fromRGBO(84, 130, 255, 1);
  restaurants['greek'].darkColor = Color.fromRGBO(59, 96, 196, 1);
  restaurants['olearys'].color = Color.fromRGBO(45, 151, 132, 1);
  restaurants['olearys'].darkColor = Color.fromRGBO(30, 105, 91, 1);
}
