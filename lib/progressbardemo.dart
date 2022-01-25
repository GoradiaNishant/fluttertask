import 'package:flutter/material.dart';

class ProgressbarDemo extends StatefulWidget {
  var tittle;
  ProgressbarDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _ProgressbarDemoState createState() => _ProgressbarDemoState();
}

class _ProgressbarDemoState extends State<ProgressbarDemo> {

  double progressvalue=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LinearProgressIndicator(value: progressvalue,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  value: progressvalue,
                  backgroundColor: Colors.yellow,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

              Slider(
                max: 1.0, min:0.0,value: progressvalue, onChanged: (value){
                  setState(() {
                    progressvalue=value;
                  });
              }),

              Text((progressvalue*100).round().toString()+"%")
            ],
          ),
        ),
      ),
    );
  }
}
