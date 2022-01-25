import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:fluttertask/audioplayer/audioplayerdemo.dart';

class AudioListDemo extends StatefulWidget {
  const AudioListDemo({Key? key}) : super(key: key);

  @override
  _AudioListDemoState createState() => _AudioListDemoState();
}

class _AudioListDemoState extends State<AudioListDemo> {

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs=[];

  Future<void> getDir() async {
    songs = await audioQuery.getSongs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getDir,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back_ios)),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 2,top: 9,bottom: 8,right: 8),
                    child: Text("AudioPlayer List",
                      style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
                  )
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AudioPlayerDemo(song: songs[index],),));
                        },
                        child: Card(
                          color: Colors.orange.shade100,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(songs[index].displayName,maxLines: 1,softWrap: true,),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(songs[index].artist,maxLines: 1,softWrap: true,),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(((int.parse(songs[index].duration) / 1000)/60).toStringAsFixed(2),maxLines: 1,softWrap: true,),
                                  ),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.favorite,color: Colors.red,))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
