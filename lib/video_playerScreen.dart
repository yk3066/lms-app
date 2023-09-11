import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  VideoPlayerScreen({required this.videoPlayerController});

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true, // Autoplay the video
      looping: false,
      // Add other configuration options as needed
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Lesson 1'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Chewie(controller: chewieController),
      ),
    );
  }
}
