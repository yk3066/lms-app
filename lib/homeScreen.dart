import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

import 'package:video_player/video_player.dart';


class HomeScreen extends StatelessWidget {
  final List<String> videoFilePaths = [
    'assets/videos/lesson1.mp4',
    // Add more video file paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player App'),
      ),
      body: ListView.builder(
        itemCount: videoFilePaths.length,
        itemBuilder: (context, index) {
          final videoPath = videoFilePaths[index];
          return VideoListItem(videoPath: videoPath);
        },
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String videoPath;

  VideoListItem({required this.videoPath});

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = VideoPlayerController.asset(videoPath);

    // Make sure the video player controller is initialized before navigating
    Future<void> initializeVideoPlayerController() async {
      await videoPlayerController.initialize();
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              videoPlayerController: videoPlayerController,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                'assets/images/video_thumbnail.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const ListTile(
              title: Text('Video Title'),
              subtitle: Text('Description of the video'),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  VideoPlayerScreen({required this.videoPlayerController});

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false, // Autoplay the video
      looping: false,
      // Add other configuration options as needed
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson 1'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 300,
              child: Chewie(controller: chewieController)),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Card(
              elevation: 0.3,
              child: Text("QGIS: Introduction 101",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,

              ),),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("IIT Bombay"),
                SizedBox(
                  width: 20,
                ),
                Text("Class :",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text(" 8")

              ],
            )
          ),



        ]
      ),
    );
  }
}
