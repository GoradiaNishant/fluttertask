import 'package:flutter/material.dart';
import 'package:fluttertask/main.dart';
import 'package:fluttertask/datetimedemo.dart';

class GridViewDemo extends StatefulWidget {
  var tittle;
  GridViewDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _GridViewDemoState createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {

  int _selectedIndex=2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tittle),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 5),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ), itemBuilder: (context, index) {
          return const Card(
            shadowColor: Colors.blueAccent,
            elevation: 20,
            color: Colors.amber,
            child: Padding(padding: EdgeInsets.all(10),child: Text("card view")),
          );
        },),
      ),
    );
  }
}


