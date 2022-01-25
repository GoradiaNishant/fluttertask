import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart';


class TimeLineDemo extends StatefulWidget {
  var tittle;
  TimeLineDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _TimeLineDemoState createState() => _TimeLineDemoState();
}

class _TimeLineDemoState extends State<TimeLineDemo> {

  var a=[
    {"timeDate":"07:30 am | September 5,2021", "task":"do something 1",},
    {"timeDate":"07:31 am | September 5,2021", "task":"do something 2",},
    {"timeDate":"07:32 am | September 5,2021", "task":"do something 3",},
    {"timeDate":"07:33 am | September 5,2021", "task":"do something 4",},
    {"timeDate":"07:34 am | September 5,2021", "task":"do something 5",},
    {"timeDate":"07:35 am | September 5,2021", "task":"do something 6",},
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: ListView.builder(
          //   itemCount: a.length,
          //   itemBuilder: (context, index) {
          //   return TimelineTile(
          //     alignment: TimelineAlign.start,
          //     isFirst: index==0,
          //     isLast: index==a.length-1,
          //     hasIndicator: true,
          //     indicatorStyle: IndicatorStyle(
          //       color: Colors.pink,
          //
          //     ),
          //     beforeLineStyle: const LineStyle(
          //       color: Colors.pink,
          //       thickness: 6,
          //     ),
          //     afterLineStyle: const LineStyle(
          //       color: Colors.pink,
          //       thickness: 6,
          //     ),
          //     endChild: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: GestureDetector(
          //         onTap: (){
          //           Fluttertoast.showToast(msg: "clicked $index",toastLength: Toast.LENGTH_SHORT);
          //         },
          //         child: Container(
          //           constraints: const BoxConstraints(
          //             minHeight: 120,
          //           ),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 40.0),
          //                 child: Text(a[index]['timeDate'].toString(),style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.only(top: 5.0),
          //                 child: Text(a[index]['task'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   );
          // },),
          child: Timeline.tileBuilder(
            theme: TimelineThemeData(
              color: Colors.pink,
              nodePosition: 0.02,
              indicatorPosition: 0.5,
              indicatorTheme: const IndicatorThemeData(
                position: 0.5,
                color: Colors.pink,
                size: 20
              ),
              connectorTheme: const ConnectorThemeData(
                space: 33,
                thickness: 5
              )
            ),
            builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.basic,
              indicatorBuilder: (context, index) {
                return Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Padding(
                    padding:const EdgeInsets.all(1),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(50)
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              connectionDirection: ConnectionDirection.before,
              connectorBuilder: (context, index, type) => SolidLineConnector(color: Colors.pink,),
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                  Padding(padding: const EdgeInsets.only(top: 40.0),
                    child: Text(a[index]['timeDate'].toString(),style: TextStyle(color: Colors.black45,fontWeight: FontWeight.bold),),
                  ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(a[index]['task'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                )
                  ],
                ),
              ),
              itemCount: a.length,
            ),
          ),
        ),
    );
  }
}
