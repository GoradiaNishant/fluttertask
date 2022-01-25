import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertask/videoplayer/videoplayerdemo.dart';

class VideoListDemo extends StatefulWidget {
  const VideoListDemo({Key? key}) : super(key: key);

  @override
  _VideoListDemoState createState() => _VideoListDemoState();
}

class _VideoListDemoState extends State<VideoListDemo> {

  final Directory _videoDir = Directory(
      '/storage/emulated/0/Movies');

  @override
  Widget build(BuildContext context) {
    if (!Directory(_videoDir.path).existsSync()) {
      return Scaffold(
        appBar: AppBar(title: const Text("Video List")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Directory not found',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      );
    } else {
      final videoList = _videoDir
          .listSync()
          .map((item) => item.path)
          .where((item) => item.endsWith('.mp4') || item.endsWith('.mkv') || item.endsWith('.avi'))
          .toList(growable: false);
      if (videoList != null) {
        if (videoList.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text("Video List")),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ListView.builder(
                itemCount: videoList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerDemo(filePath: videoList[index].toString(),),));
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(videoList[index].toString()),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Sorry, No Videos Found.',
              style: TextStyle(fontSize: 18.0),
            ),
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  }
}
