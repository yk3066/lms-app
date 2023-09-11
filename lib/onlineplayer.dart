import 'package:flutter/material.dart';
import 'package:geoguru/downloadsScreen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

List<bool> enrol = [false, false];
List <String> Images =[
  'assets/download.png',
  'assets/flutter.png'
];
class OnlineHomeScreen extends StatefulWidget {
  @override
  _OnlineHomeScreenState createState() => _OnlineHomeScreenState();
}

class _OnlineHomeScreenState extends State<OnlineHomeScreen> {
  List<List<String>> youtubeVideolist = [
    ['NHolzMgaqwE', "QGIS", "GeoDelta Labs"], // Replace with actual YouTube video IDs
    ['1ukSR1GRtMU', "Flutter Tutorial", "The Net Ninja"],
    // Add more YouTube video IDs here
  ];

   // Initialize with default enrollment status
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
              child: Icon(Icons.school),
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
              child: Icon(Icons.download_for_offline_rounded,color: Colors.grey,),
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
        title: Text('Video Player App'),
      ),
      body: ListView.builder(
        itemCount: youtubeVideolist.length,
        itemBuilder: (context, index) {
          final youtubeVideo = youtubeVideolist[index];
          return VideoListItem(
            youtubeVideoId: youtubeVideo[0],
            title: youtubeVideo[1],
            desc: youtubeVideo[2],
            isEnrolled: index, // Pass the enrollment status
          );
        },
      ),
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String youtubeVideoId;
  final String title;
  final String desc;
  final int isEnrolled;


  VideoListItem({
    required this.youtubeVideoId,
    required this.title,
    required this.desc,
    required this.isEnrolled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(
              youtubeVideoId: youtubeVideoId,
              title: title,
              desc: desc,
              enrolled : isEnrolled
            ),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
               Images[isEnrolled],
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
  final String youtubeVideoId;
  final String title;
  final String desc;
  final int enrolled;

  VideoPlayerScreen({
    required this.youtubeVideoId,
    required this.title,
    required this.desc,
    required this.enrolled,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
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
              child: Icon(Icons.school),
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
              child: Icon(Icons.download_for_offline_rounded,color: Colors.grey,),
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
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: widget.youtubeVideoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true, // Autoplay the video
                  mute: false,
                ),
              ),
            ),
          ),
          // Other content remains unchanged
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
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    height: 65,
                    width: 160,

                    child: ElevatedButton(onPressed: (){
                      setState(() {
                        enrol[widget.enrolled] = true;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => OfflineHomeScreen()
                          ),
                        );// Toggle the enrollment status
                      });// Toggle the enrollment status
                    },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                        ),
                        child: Text(enrol[widget.enrolled]?"Enrolled": "Enroll Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),)),
                  ),
                )
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
          )

        ],
      ),
    );
  }
}
