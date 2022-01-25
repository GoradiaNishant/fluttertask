import 'package:flutter/material.dart';

class AlertDialogDemo extends StatefulWidget {

  var tittle;
  AlertDialogDemo({this.tittle});


  @override
  _AlertDialogDemoState createState() => _AlertDialogDemoState();
}

class _AlertDialogDemoState extends State<AlertDialogDemo> {

  void _showDialog1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!!"),
          content: const Text("Alert Dialog with Just Conformation"),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!!"),
          content: const Text("Alert Dialog with Just Conformation"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void _showDialog3(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alert!!"),
          content: const Text("Alert Dialog with Just Conformation"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Don't ask me again"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              color: Colors.blue,
              onPressed: (){
                _showDialog1(context);
              },child: const Text("AlertDialog type 1"),),
            RaisedButton(
              color: Colors.blue,
              onPressed: (){
                _showDialog2(context);
              },child: const Text("AlertDialog type 2"),),
            RaisedButton(
              color: Colors.blue,
              onPressed: (){
                _showDialog3(context);
              },child: const Text("AlertDialog type 3"),),
          ],
        ),
      ),
    );
  }
}
