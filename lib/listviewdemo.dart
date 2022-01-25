import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  var tittle;
  ListViewDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _ListViewDemoState createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            shadowColor: Colors.blueAccent,
            elevation: 20,
            color: Colors.amber,
            child: Padding(padding: EdgeInsets.all(10),child: Text("card view")),
          ),
        );
      },),
    );
  }
}
