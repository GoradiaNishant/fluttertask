import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/NotificationDemo.dart';
import 'package:fluttertask/alertdialogdemo.dart';
import 'package:fluttertask/audioplayer/audiolist.dart';
import 'package:fluttertask/bottomsheetdemo.dart';
import 'package:fluttertask/chartsdemo.dart';
import 'package:fluttertask/databases/databasedemo.dart';
import 'package:fluttertask/datetimedemo.dart';
import 'package:fluttertask/listviewdemo.dart';
import 'package:fluttertask/gridviewdemo.dart';
import 'package:fluttertask/permissiondemo.dart';
import 'package:fluttertask/progressbardemo.dart';
import 'package:fluttertask/signin.dart';
import 'package:fluttertask/src/ui/movie_list.dart';
import 'package:fluttertask/tabbardemo.dart';
import 'package:fluttertask/timelinedemo.dart';
import 'package:fluttertask/videoplayer/videolistdemo.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // supportedLocales: const [
      //   Locale( 'en' , 'US' ),
      //   Locale( 'hi' , 'IN' ),
      // ],
      // localizationsDelegates: const [
      //   AppLocalizations.delegate, // Add this line
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SplashDemo(),
    );
  }
}


class SplashDemo extends StatefulWidget {
  const SplashDemo({Key? key}) : super(key: key);

  @override
  _SplashDemoState createState() => _SplashDemoState();
}

class _SplashDemoState extends State<SplashDemo> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/signupbg.jpg'),
            fit: BoxFit.fill
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              FlutterLogo(size:250),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Flutter Tasks",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40,color: Colors.deepOrange,fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final int _selectedIndex = 0;

  // Locale temp=Locale('hi','IN');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task1"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[

            DrawerHeader(
              decoration:const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/signupbg.jpg"),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          children: const [
                            CircleAvatar(
                              child: Icon(Icons.android),
                              backgroundColor: Colors.black,
                              radius: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("All Tasks",textAlign: TextAlign.left,),
                            ),
                          ],
                        ),


                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChartDemo(tittle: 'Flutter Charts',),));
                          },
                          child: Column(
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.add_chart,color: Colors.pink,),
                                backgroundColor: Colors.white,
                                radius: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Flutter Charts Demo",textAlign: TextAlign.left,),
                              ),
                            ],
                          ),
                        )


                      ],
                    ),




                  ],
                ),
              ),
            ),
            //Draweritemslist
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //Widgets
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ExpansionTile(
                      title: const Text("Widgets Examples"),
                      children: <Widget>[

                        //timeline
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TimeLineDemo(tittle: "Timeline Demo",),));
                                Fluttertoast.showToast(msg: "TimeLine Widget",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("Timeline Widget")
                                ],
                              ),),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomSheetDemo(tittle: "BottomSheet demo",),));
                                Fluttertoast.showToast(msg: "BottomSheet",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("BottomSheet")
                                ],
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AlertDialogDemo(tittle: "AlertDialog demo",),));
                                Fluttertoast.showToast(msg: "AlertDialog",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("AlertDialog")
                                ],
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DateTimeDemo(tittle: "DateTimePicker demo",),));
                                Fluttertoast.showToast(msg: "DateTime",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("DateTime")
                                ],
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProgressbarDemo(tittle: "Progressbar Validation demo",),));
                                Fluttertoast.showToast(msg: "Progressbar",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("Progressbar")
                                ],
                              ),),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                //views
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ExpansionTile(
                      title: const Text("View Examples"),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ListViewDemo(tittle: "ListView demo",),));
                                Fluttertoast.showToast(msg: "ListView",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("ListView")
                                ],
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => GridViewDemo(tittle: "GridView demo",),));
                                Fluttertoast.showToast(msg: "GridView",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("GridView")
                                ],
                              ),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarDemo(tittle: "TabBar demo",),));
                                Fluttertoast.showToast(msg: "TabBar",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("TabBarView")
                                ],
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //notifications & permission
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ExpansionTile(
                      title: const Text("Notifications and Permissions Examples"),
                      children: <Widget>[
                        //notification
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDemo(tittle: "Notification demo",),));
                                Fluttertoast.showToast(msg: "Notification",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("Notification")
                                ],
                              ),),
                          ),
                        ),

                        //permissions
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PermissionDemo(tittle: "Permissions check demo",),));
                                Fluttertoast.showToast(msg: "Permissions",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("Permissions")
                                ],
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //signin validation
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(tittle: "SignIn Validation and Firebase Auth demo",),));
                        Fluttertoast.showToast(msg: "SignIn",toastLength: Toast.LENGTH_SHORT,);
                      },
                      child: Row(
                        children: const [
                          Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                          Expanded(child: Text("SignIn Validation and Firebase Auth demo",maxLines: 1,))
                        ],
                      ),),
                  ),
                ),
                //players
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 2,
                    child: ExpansionTile(
                      title: const Text("Players Examples"),
                      children: <Widget>[
                        //audioplayer
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AudioListDemo(),));
                                Fluttertoast.showToast(msg: "AudioPlayer",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("AudioPlayer")
                                ],
                              ),),
                          ),
                        ),
                        //videoplayer
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => VideoListDemo(),));
                                Fluttertoast.showToast(msg: "Videoplayer",toastLength: Toast.LENGTH_SHORT,);
                              },
                              child: Row(
                                children: const [
                                  Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                                  Text("VideoList")
                                ],
                              ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //firebase
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DatabaseDemo(),));
                        Fluttertoast.showToast(msg: "FirebaseRDB",toastLength: Toast.LENGTH_SHORT,);
                      },
                      child: Row(
                        children: const [
                          Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                          Text("Firebase RDB")
                        ],
                      ),),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieList(),));
                        Fluttertoast.showToast(msg: "Movie List(BlocPatern)",toastLength: Toast.LENGTH_SHORT,);
                      },
                      child: Row(
                        children: const [
                          Padding(padding: EdgeInsets.all(12),child: Icon(Icons.android,size: 35,)),
                          Text("Bloc Pattern Impl")
                        ],
                      ),),
                  ),
                ),

            ],),

          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            const Text("Carousel Demo"),
            CarouselSlider(items: [

              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),


              Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image:const DecorationImage(
                    image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            ], options: CarouselOptions(
              height: 200,aspectRatio: 16/9,enableInfiniteScroll: false
            )),


            const Text("Switch Demo", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Text("Selected Index is :- "+_selectedIndex.toString(),style: const TextStyle(fontSize: 20),)
          ],
        ),
      ) ,
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){},
        child: const Icon(Icons.send), //icon inside button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomNavigationBar(
      //     items: const[
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.business),
      //         label: 'Business',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.school),
      //         label: 'School',
      //       ),
      //     ],
      //     currentIndex: _selectedIndex,
      //     selectedItemColor: Colors.amber[800],
      //     onTap: (a){
      //       setState(() {
      //         _selectedIndex=a;
      //       });
      //     },
      //   ),
      bottomNavigationBar: BottomAppBar(
        color:Colors.blue,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
            IconButton(icon: const Icon(Icons.search, color: Colors.white,), onPressed: () {},),
            IconButton(icon: const Icon(Icons.print, color: Colors.white,), onPressed: () {},),
            IconButton(icon: const Icon(Icons.people, color: Colors.white,), onPressed: () {},),
          ],
        ),
      ),
    );
  }
}
