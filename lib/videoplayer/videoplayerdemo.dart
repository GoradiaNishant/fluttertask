import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_video_info/flutter_video_info.dart';

class VideoPlayerDemo extends StatefulWidget {
  var filePath;
  VideoPlayerDemo({Key? key,this.filePath}) : super(key: key);

  @override
  _VideoPlayerDemoState createState() => _VideoPlayerDemoState();
}

class _VideoPlayerDemoState extends State<VideoPlayerDemo> {

  late VideoPlayerController _controller;

  late var info;
  final videoInfo = FlutterVideoInfo();

  void getVideoInfo()async{
    info = await videoInfo.getVideoInfo(widget.filePath);

  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        setState(() {
          length=_controller.value.duration;
        });
      });


    _controller.addListener(() {
      if(_controller.value.isPlaying){
        setState(() {
          position=_controller.value.position;
        });
      }
    });
  }

  Duration position=const Duration(milliseconds: 0);
  Duration length= const Duration(milliseconds: 0);

  bool isfull=false;

  bool hover=true;

  @override
  void dispose(){
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isfull?Scaffold(
      body: Stack(
        children: [
          InkWell(
              onTap: (){
                print("hover"+hover.toString());
                setState(() {
                  hover=true;
                  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                  print("hover"+hover.toString());
                });

                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    hover=false;
                    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
                    print("hover"+hover.toString());
                  });
                });
              },child: VideoPlayer(_controller)),
          Visibility(
            visible: hover,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // VideoProgressIndicator(_controller, allowScrubbing: true),

                  Slider.adaptive(
                    activeColor: Colors.white,
                    max: length.inSeconds.toDouble(),
                    value: position.inSeconds.toDouble(),
                    onChanged: (value){
                      setState(() {
                        _controller.seekTo(Duration(seconds: value.toInt()));
                      });
                    },
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: IconButton(onPressed: (){
                            setState(() {
                              _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds-10));
                            });
                          }, icon: const Icon(Icons.skip_previous,color: Colors.white,size: 40,)),
                        ),
                        Expanded(
                          child: IconButton(onPressed: (){
                           setState(() {
                             _controller.value.isPlaying
                                 ? _controller.pause()
                                 : _controller.play();
                           });
                          }, icon: _controller.value.isPlaying
                              ?const Icon(Icons.pause_circle_filled,color: Colors.white,size: 40)
                              :const Icon(Icons.play_circle_fill_outlined,color: Colors.white,size: 40)
                          ),
                        ),

                        Expanded(
                          child: IconButton(onPressed: (){
                            setState(() {
                              _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds+10));
                            });
                          }, icon: Icon(Icons.skip_next_sharp,color: Colors.white,size: 40)),
                        ),

                        Expanded(
                          child: IconButton(onPressed: (){
                            setState(() {
                              isfull=false;
                              SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeRight,
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.portraitUp
                              ]);
                            });
                          }, icon: const Icon(Icons.fullscreen,color: Colors.white,size: 40,)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ):Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: _controller.value.isInitialized?AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Container(
                child: Text(""),
              ),
            ),
            VideoProgressIndicator(_controller, allowScrubbing: true),
            IconButton(onPressed: (){
              setState(() {
                isfull=true;
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.landscapeLeft,
                ]);
              });
            }, icon: Icon(Icons.fullscreen))
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}


