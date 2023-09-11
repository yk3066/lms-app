import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:geoguru/onlineplayer.dart';

import 'package:video_player/video_player.dart';

List<List<String>> youtubeVideolist = [
  ['NHolzMgaqwE', "QGIS", "GeoDelta Labs"], // Replace with actual YouTube video IDs
  ['1ukSR1GRtMU', "Flutter Tutorial", "The Net Ninja"],
  // Add more YouTube video IDs here
];
List <String> Images =[
  'assets/download.png',
  'assets/flutter.png'
];
class OfflineHomeScreen extends StatefulWidget {

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  final List<String> videoFilePaths = [
    'assets/videos/lesson1.mp4',
    // Add more video file paths here
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex, // Set the current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected index on tap
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnlineHomeScreen()),
                );
              },
              child: Icon(Icons.school,color: Colors.grey,),
            ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OfflineHomeScreen()),
                );
                // Handle button press for 'Downloads'
              },
              child: Icon(Icons.download_for_offline_rounded,color: Colors.blue,),
            ),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                // Handle button press for 'Profile'
              },
              child: Icon(Icons.account_circle_sharp, color: Colors.grey,),
            ),
            label: 'Profile',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Video Player App'),
      ),
      body: ListView.builder(
        itemCount: videoFilePaths.length,
        itemBuilder: (context, index) {
          final videoPath = videoFilePaths[index];
          final title = youtubeVideolist[index][1];
          final desc = youtubeVideolist[index][2];
          return VideoListItem(videoPath: videoPath, title : title, desc: desc);
        },
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String videoPath;
  final String title;
  final String desc;

  VideoListItem({required this.videoPath, required this.title, required this.desc});

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
              title: title,
              desc: desc,
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
               Images[0],
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text(title),
              subtitle: Text(desc),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String title;
  final String desc;
  VideoPlayerScreen({required this.videoPlayerController,
    required this.title,
    required this.desc,});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      autoPlay: false, // Autoplay the video
      looping: false,
      // Add other configuration options as needed
    );

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex, // Set the current selected index
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Update selected index on tap
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnlineHomeScreen()),
                );
              },
              child: Icon(Icons.school,color: Colors.grey,),
            ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OfflineHomeScreen()),
                );
                // Handle button press for 'Downloads'
              },
              child: Icon(Icons.download_for_offline_rounded),
            ),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: TextButton(
              onPressed: () {
                // Handle button press for 'Profile'
              },
              child: Icon(Icons.account_circle_sharp, color: Colors.grey,),
            ),
            label: 'Profile',
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(widget.title),
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
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 0.3,
                    child: Text(widget.title,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,

                      ),),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("By : ${widget.desc}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                ),),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce eget ante sed ligula fermentum bibendum. Nullam eu semper urna. Suspendisse potenti. Nulla facilisi. Nulla facilisi. Proin auctor quam a felis laoreet, ac blandit nulla consectetur. Sed volutpat purus at est scelerisque, nec efficitur justo feugiat. Cras in bibendum tortor. Vivamus maximus nunc eget orci commodo, nec pharetra enim volutpat. Vivamus in justo a metus cursus consequat. Curabitur eget tincidunt nulla. Quisque sagittis tristique tortor, nec hendrerit lectus rhoncus in. In hac habitasse platea dictumst.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 24
                ),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 65,
                    width: 160,

                    child: ElevatedButton(onPressed: (){


                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        child: Text("Previous Lecture",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 65,
                    width: 160,

                    child: ElevatedButton(onPressed: (){

                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        child: Text("Next Lecture",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),)),
                  ),
                )
              ],
            )

          ]
      ),
    );
  }
}
