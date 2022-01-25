import 'package:flutter/material.dart';

class BottomSheetDemo extends StatefulWidget {

  var tittle;
  BottomSheetDemo({this.tittle});

  @override
  _BottomSheetDemoState createState() => _BottomSheetDemoState();
}

class _BottomSheetDemoState extends State<BottomSheetDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tittle),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          showModalBottomSheet(context: context, builder: (context) {
            return Container(
              color: Colors.blue,
              child: const Center(child: Text("BottomSheetDemo"),),
            );
          },);
        },
          child: const Text("Bottom Sheet"),
        ),
      ),
    );
  }
}
