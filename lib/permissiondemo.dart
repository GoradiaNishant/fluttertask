import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDemo extends StatefulWidget {
  var tittle;
  PermissionDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _PermissionDemoState createState() => _PermissionDemoState();
}

class _PermissionDemoState extends State<PermissionDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tittle),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                var status = await Permission.camera.status;
                if (status.isDenied) {
                 await Permission.camera.request();
                }
                // if (await Permission.location.isRestricted) {
                  print(status);
                // }
              }, child: const Text("Camera")),

              ElevatedButton(onPressed: () async {
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  await Permission.storage.request();
                }
                // if (await Permission.location.isRestricted) {
                print(status);
                // }
              }, child: const Text("Storage")),

              ElevatedButton(onPressed: () async {
                var status = await Permission.camera.status;
                if (status.isDenied) {
                  await Permission.location.request();
                }
                print(status);
              }, child: const Text("location")),

            ],
          ),
        ),
      ),
    );
  }
}
