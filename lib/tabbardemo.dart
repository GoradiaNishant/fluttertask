import 'package:flutter/material.dart';

class TabBarDemo extends StatefulWidget {
  var tittle;
  TabBarDemo({Key? key,this.tittle}) : super(key: key);

  @override
  _TabBarDemoState createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(widget.tittle,style: const TextStyle(color: Colors.black),),
            bottom: TabBar(
             unselectedLabelColor: Colors.blue,
             indicator: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
               color: Colors.blue
             ),
              tabs: const [
                Tab(icon: Icon(Icons.android,),),
                Tab(icon: Icon(Icons.android,),),
                Tab(icon: Icon(Icons.android,),)
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(child: Text("Tab 1")),
              Center(child: Text("Tab 2")),
              Center(child: Text("Tab 3")),
            ],
          ),
        )
    );
  }
}
