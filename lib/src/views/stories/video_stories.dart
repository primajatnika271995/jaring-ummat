import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_simple_video_player/flutter_simple_video_player.dart';

class VideoStories extends StatefulWidget {
  String userId;
  VideoStories({@required this.userId});

  @override
  _VideoStoriesState createState() => _VideoStoriesState();
}

class _VideoStoriesState extends State<VideoStories> {
  List<VideoPlayerController> _controllers = [];
  List<String> url = [
    "http://139.162.15.91:80/e911b88c-ba6d-441e-ab7d-025cabc40abc.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1",
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1',
  ];

  int index = 0;
  double _progress = 0;
  bool _changeLock = false;

  @override
  void initState() {
    super.initState();
  }

  Future<Null> dataUrlList() async {
    StoriesApiProvider().storiesList(widget.userId).then((response) {
      var data = json.decode(response.body);
      StoryByUser list = StoryByUser.fromJson(data);
      list.storyList.forEach((val) {
        if (val.contents[0].imgUrl == null) {
          print('Video ${val.contents[0].videoUrl}');
          setState(() {
            url.add(val.contents[0].videoUrl);
          });
        }
        print(url.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//            print(url.length);
        return Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                children: <Widget>[
                  SimpleViewPlayer(
                    "http://139.162.15.91:80/e911b88c-ba6d-441e-ab7d-025cabc40abc.mp4",
                    isFullScreen: false,
                  ),
                  SimpleViewPlayer(
                    "http://139.162.15.91:80/d417c874-5a9b-4028-b18c-c55b6501b5da.mp4",
                    isFullScreen: false,
                  ),
                ],
              ),
            ),
            Positioned(
              child: Container(
                height: 10,
                width: MediaQuery.of(context).size.width * _progress,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 20.0,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Next'),
                onPressed: () {},
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 110.0,
              child: RaisedButton(
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Prev'),
                onPressed: () {},
              ),
            ),
          ],
        );
      },
    ));
  }
}
