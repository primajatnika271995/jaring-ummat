import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:flutter_jaring_ummat/src/services/time_ago_service.dart';
import '../../services/storyByUser.dart';

class UserStoryContainerOld extends StatefulWidget {
  String userId;
  String createdBy;
  String video;
  int createdDate;
  UserStoryContainerOld(
      {@required this.userId,
        this.createdBy,
        this.createdDate,
        @required this.video});

  @override
  State<StatefulWidget> createState() {
    return UserStoryContainerOldState();
  }
}

class UserStoryContainerOldState extends State<UserStoryContainerOld> {
  List<Content> urlContent = List<Content>();

  @override
  void initState() {
    super.initState();
    print("userid : ${widget.userId}");
    storiesList(widget.userId).then((response) {
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
                flex: 10,
                child: Container(
                  margin: EdgeInsets.fromLTRB(1.0, 25.0, 4.0, 1.0),
                  child: storiesView(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: 30.0,
                          height: 30.0,
                          // margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://www.skylightsearch.co.uk/wp-content/uploads/2017/01/Loren-profile-pic-circle.png")),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 13,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 0.0),
                            child: TextField(
                              autocorrect: false,
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                icon: Icon(Icons.search, size: 18.0),
                                border: InputBorder.none,
                                hintText: 'Send Message',
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0)),
                            color: Colors.grey[200],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 0.5, 15.0, 0.5),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
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
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://www.skylightsearch.co.uk/wp-content/uploads/2017/01/Loren-profile-pic-circle.png"),
                        fit: BoxFit.contain,
                      )),
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
          widgetList.add(
            StoryItem.pageVideo(urlContent[i].videoUrl)
//              StoryItem.text(urlContent[i].videoUrl, Colors.blue)

          );
        });
      }

      if (urlContent[i].videoUrl == null) {
        setState(() {
          widgetList.add(
            StoryItem.pageImage(
              NetworkImage(urlContent[i].imgUrl),
              caption: "Ini Stories konten ${widget.createdBy}",
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

  Future<http.Response> storiesList(String userId) async {
    var response = await http
        .get("http://139.162.15.91/jaring-ummat/api/stories/list/${userId}");
    return response;
  }
}
