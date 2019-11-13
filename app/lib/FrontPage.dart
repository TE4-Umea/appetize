import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'RestaurantWidget.dart';

class FrontPage extends StatelessWidget {
  Map restaurants;
  FrontPage(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: backgroundColor,
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
                Padding(
                  child: Chart(restaurants['olearys'].color,
                      restaurants['olearys'].darkColor),
                  padding: EdgeInsets.all(20),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Chart extends StatefulWidget {
  Color primary, secondary;
  Chart(this.primary, this.secondary);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 1),
                FlSpot(2.6, 1),
                FlSpot(4.9, 1),
                FlSpot(6.8, 3),
                FlSpot(8, 1),
                FlSpot(9.5, 1),
                FlSpot(11, 1),
              ],
              isCurved: true,
              colors: [widget.primary, widget.secondary],
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: const FlDotData(
                show: false,
                dotColor: Colors.red,
              ),
              belowBarData: BarAreaData(
                show: true,
                colors: [
                  widget.primary.withOpacity(.3),
                  widget.secondary.withOpacity(.3)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
