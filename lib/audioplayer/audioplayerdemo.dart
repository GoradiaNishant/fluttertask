import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AudioPlayerDemo extends StatefulWidget {

  SongInfo song;

  AudioPlayerDemo({Key? key,required this.song}) : super(key: key);

  @override
  _AudioPlayerDemoState createState() => _AudioPlayerDemoState();
}

class _AudioPlayerDemoState extends State<AudioPlayerDemo> {

  Duration position=const Duration(milliseconds: 0);
  Duration length= const Duration(milliseconds: 0);

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  playMusic() async{
    await audioPlayer.play(widget.song.filePath);
    // await audioCache.play('assets/audio/song1.mp3');
  }

  pauseMusic() async{
    await audioPlayer.pause();
  }

  AudioPlayer audioPlayer =AudioPlayer();

  late AudioCache audioCache;

  @override
  void initState() {
    audioCache= AudioCache(fixedPlayer: audioPlayer);
    super.initState();

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        length=event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position=event;
      });
    });
  }

  bool isplaying=false;

  double currentpos=0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios)),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 2,top: 9,bottom: 8,right: 8),
                    child: Text("AudioPlayer List",
                      style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,),),
                  )
                ],
              ),

              SizedBox(height: 30,),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.deepOrange,
                child: SizedBox(
                  width: 230,
                  height: 230,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 30,
                      shadowColor: Colors.black,
                      child: const CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.music_note,size: 80,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
                elevation: 10,

              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(widget.song.displayName.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black87,fontSize: 23,fontWeight: FontWeight.bold,),),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(widget.song.artist,
                  style: const TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.bold,),),
              ),

              const SizedBox(height: 30,),
              Card(
                color: Colors.orange.shade100,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                  ),
                ),
                shadowColor: Colors.deepOrange,
                child: SizedBox(
                  width: double.infinity,
                  height: 380,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:const EdgeInsets.all(10),
                              child: Text(position.inMinutes.toString()+":"+position.inSeconds.remainder(60).toString(),
                                style: const TextStyle(color: Colors.black87,fontSize: 23,fontWeight: FontWeight.bold,),),
                            ),

                            Expanded(
                              child: Slider.adaptive(
                                activeColor: Colors.deepOrange,
                                max: length.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (value){
                                  audioPlayer.seek(Duration(seconds: value.toInt()));
                                },),
                            ),

                            Padding(
                              padding:const EdgeInsets.all(6),
                              child: Text(length.inMinutes.toString()+":"+length.inSeconds.remainder(60).toString(),
                                style: const TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold,),),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                child: Icon(Icons.skip_previous),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.deepOrange,
                                child: IconButton(onPressed: ()async{
                                  playMusic();
                                  setState(() {
                                    isplaying=true;
                                  });
                                }, icon: const Icon(Icons.play_circle_fill,size: 30,)),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.deepOrange,
                                child: IconButton(onPressed: (){
                                  audioPlayer.pause();
                                  setState(() {
                                    isplaying=false;
                                  });
                                }, icon: isplaying? const Icon(Icons.pause_circle_filled,size: 30,): const Icon(Icons.stop_circle_rounded,size: 30,)),
                              ),
                            ),

                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                child: Icon(Icons.skip_next_sharp),
                              ),
                            ),

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [

                            Padding(
                              padding: EdgeInsets.all(12),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                child: Icon(Icons.playlist_play),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                child: Icon(Icons.playlist_add_outlined),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepOrange,
                                child: Icon(Icons.favorite_border_sharp),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
