import 'dart:async';
import 'dart:convert';
import 'package:flutter_jaring_ummat/src/config/hexColor.dart';
import 'package:flutter_jaring_ummat/src/views/components/video_player_container.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import 'package:flutter_jaring_ummat/src/services/storiesApi.dart';
import 'package:flutter_jaring_ummat/src/models/storyByUser.dart';
import 'package:video_player/video_player.dart';

class UserStoryContainerOld extends StatefulWidget {
  String userId;
  String createdBy;
  int createdDate;
  UserStoryContainerOld({
    @required this.userId,
    this.createdBy,
    this.createdDate,
  });

  @override
  State<StatefulWidget> createState() {
    return UserStoryContainerOldState();
  }
}

class UserStoryContainerOldState extends State<UserStoryContainerOld> {
  List<Content> urlContent = List<Content>();
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    getStoryList();
  }

  void getStoryList() {
    StoriesApiProvider api = new StoriesApiProvider();
    print("userid : ${widget.userId}");
    api.storiesList(widget.userId).then((response) {
      var data = json.decode(response.body);
      StoryByUser stories = StoryByUser.fromJson(data);
      stories.storyList.forEach((val) {
        setState(() {
          urlContent.add(val.contents[0]);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.fromLTRB(1.0, 25.0, 4.0, 1.0),
                  child: storiesView(),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0.0,
            top: 0.0,
            width: MediaQuery.of(context).size.width,
            height: 130.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black45, Colors.black45.withOpacity(0.1)],
                ),
              ),
            ),
          ),
          Positioned(
            top: 70.0,
            left: 40.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: greenColor,
                  child: Text(widget.createdBy.substring(0, 1).toUpperCase(), style: TextStyle(color: whiteColor, fontSize: 18.0),),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.createdBy,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      TimeAgoService().timeAgoFormatting(widget.createdDate),
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget storiesView() {
    List<StoryItem> widgetList = new List<StoryItem>();
    for (var i = 0; i < urlContent.length; i++) {
      if (urlContent[i].imgUrl == null) {
        setState(() {
          widgetList.add(StoryItem.text(urlContent[i].videoUrl, Colors.blue)
              // StoryItem.pageVideo(urlContent[i].videoUrl, urlContent[i].thumbnailUrl),
              );
        });
      }

      if (urlContent[i].videoUrl == null) {
        setState(() {
          widgetList.add(
            StoryItem.pageImage(
              NetworkImage(urlContent[i].imgUrl),
              caption: "Ini Stories konten ${widget.createdBy}",
              imageFit: BoxFit.cover,
            ),
          );
        });
      }
    }

    if (widgetList.isEmpty) {
      return Container(
        color: Colors.blue,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ),
      );
    }

    return StoryView(
      widgetList,
      onStoryShow: (s) {
        print("Showing a story");
      },
      onComplete: () {
        print("Completed a cycle");
      },
      progressPosition: ProgressPosition.top,
      repeat: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
