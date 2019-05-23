import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {

  Widget _buildPositionedStack() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 100,
              height: 300,
              color: Colors.redAccent,
            ),
          ),

          Positioned(
            left: 120,
            top: 20,
            child: Container(
              width: 100,
              height: 200,
              color: Colors.greenAccent,
            ),
          ),

          Positioned(
            right: 20,
            top: 20,
            child: Container(
              width: 100,
              height: 200,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gauge Chart'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
             Container(
               width: 300,
               height: 300,
               child: _GaugeChart.withRandomData(),
             ),
             _buildPositionedStack()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}


class _GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  _GaugeChart(this.seriesList, {this.animate});

  factory _GaugeChart.withSampleData() {
    return _GaugeChart(
      _createSampleData(),
      animate: false,
    );
  }

  factory _GaugeChart.withRandomData() {
    return _GaugeChart(
      _createRandomData(),
      animate: false,
    );
  }

  static List<charts.Series<GaugeSegment, String>> _createRandomData() {
    final random = Random();
    final data = [
      GaugeSegment('Low', random.nextInt(100)),
      GaugeSegment('Acceptable', random.nextInt(100)),
      GaugeSegment('High', random.nextInt(100)),
      GaugeSegment('Highly Unusual', random.nextInt(100))
    ];
    return [
      charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (segment, _) => segment.segment,
        measureFn: (segment, _) => segment.size,
        data: data,
      )
    ];
  }

  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      GaugeSegment('Low', 75),
      GaugeSegment('Acceptable', 100),
      GaugeSegment('High', 50),
      GaugeSegment('Highly Unusual', 5)
    ];

    return [charts.Series<GaugeSegment, String>(
      id: 'Segments',
      domainFn: (segment, _) => segment.segment,
      measureFn: (segment, _) => segment.size,
      data: data
    )];
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      defaultRenderer: charts.ArcRendererConfig(
        arcWidth: 30,
        startAngle: 4 / 5 * pi,
        arcLength: 7 / 5 * pi
      ),
    );
  }
}

class GaugeSegment {
  final String segment;
  final int size;
  GaugeSegment(this.segment, this.size);
}
