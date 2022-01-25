import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _SalesData{
  var month;
  var year;
  _SalesData(this.year,this.month);
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}

class ChartDemo extends StatefulWidget {
  var tittle;
  ChartDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _ChartDemoState createState() => _ChartDemoState();
}

class _ChartDemoState extends State<ChartDemo> {

  _ChartDemoState(){
    timer =
        Timer.periodic(const Duration(seconds: 2), _updateDataSource);
  }

  final ZoomPanBehavior _zoomPan=ZoomPanBehavior(
    enableDoubleTapZooming: true,
    enablePanning: true,
    enablePinching: true,
    enableSelectionZooming: true,
  );

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 35),
    _SalesData('Jul', 28),
    _SalesData('Aug', 34),
    _SalesData('Sep', 32),
    _SalesData('Nov', 40)
  ];

  List<_PieData> pieData = [
    _PieData('jan', 10, 'text1'),
    _PieData('feb', 11, 'text2'),
    _PieData('mar', 12, 'text3'),
    _PieData('apr', 13, 'text4'),
    _PieData('jun', 14, 'text5'),
    _PieData('jul', 15, 'text6'),
  ];

  int _getRandomInt(int min, int max) {
    final math.Random _random = math.Random();
    return min + _random.nextInt(max - min);
  }

  Timer? timer;
  int count=20;
  ChartSeriesController? _chartSeriesController;

  void _updateDataSource(Timer timer) {
    data.add(_SalesData('count$count', _getRandomInt(10, 100)));
      if (data.length == 20) {
        data.removeAt(0);
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[data.length - 1],
          removedDataIndexes: <int>[0],
        );
      } else {
        _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[data.length - 1],
        );
      }
      count = count + 1;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(isVisible: false),
                    primaryYAxis: CategoryAxis(isVisible: false),
                    plotAreaBorderWidth: 0,
                    title: ChartTitle(text: 'Live Chart'),
                    legend: Legend(isVisible: false),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <AreaSeries<_SalesData, String>>[
                      AreaSeries<_SalesData, String>(
                          onRendererCreated: (ChartSeriesController controller) {
                            _chartSeriesController = controller;
                          },

                          borderColor: Colors.green,
                          borderWidth: 2,
                          dataSource: data,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.month,
                          name: 'Sales',
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                          gradient: LinearGradient(
                              colors: <Color>[Colors.teal[50]!, Colors.teal[200]!, Colors.teal],
                              stops: const <double>[0.0, 0.4, 1.0],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter)
                      )
                    ],
                    zoomPanBehavior: _zoomPan
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){
                  _zoomPan.zoomIn();
                }, icon: Icon(Icons.zoom_in,size: 50,)),

                IconButton(onPressed: (){
                  _zoomPan.zoomOut();
                }, icon: Icon(Icons.zoom_out,size: 50,))

              ],
            ),

            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: SfCircularChart(
                  title: ChartTitle(text: 'Pie Chart'),
                  legend: Legend(isVisible: true),
                  series: <PieSeries<_PieData,String>>[
                    PieSeries<_PieData, String>(
                        explode: true,
                        explodeIndex: 1,
                        dataSource: pieData,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: const DataLabelSettings(isVisible: true)),
                  ],
                ),
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child:  SfCircularChart(
                  title: ChartTitle(text: 'Pie Chart'),
                  legend: Legend(
                      isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <DoughnutSeries<_PieData,String>>[
                    DoughnutSeries<_PieData,String>(
                        radius: '80%',
                        explode: true,
                        explodeOffset: '10%',
                        startAngle: 90,
                        endAngle: 90,
                        xValueMapper: (_PieData data, _) => data.xData,
                        yValueMapper: (_PieData data, _) => data.yData,
                        dataSource: pieData,
                        dataLabelMapper: (_PieData data, _) => data.text,
                        dataLabelSettings: const DataLabelSettings(isVisible: true,labelPosition: ChartDataLabelPosition.outside)
                    )
                  ],

                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
